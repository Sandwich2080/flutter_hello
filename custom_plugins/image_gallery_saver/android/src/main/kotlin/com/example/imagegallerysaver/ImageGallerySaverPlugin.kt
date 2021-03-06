package com.example.imagegallerysaver

import android.content.ContentValues
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.IOException

class ImageGallerySaverPlugin(private val registrar: Registrar) : MethodCallHandler {

    companion object {

        val TAG = ImageGallerySaverPlugin::class.java.simpleName

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "image_gallery_saver")
            channel.setMethodCallHandler(ImageGallerySaverPlugin(registrar))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        when {
            call.method == "saveImageToGallery" -> {
                val image = call.arguments as ByteArray
                result.success(saveImageToGallery(BitmapFactory.decodeByteArray(image, 0, image.size)))
            }
            call.method == "saveFileToGallery" -> {
                val path = call.arguments as String
                result.success(saveFileToGallery(path))
            }
            else -> result.notImplemented()
        }

    }

    private fun debugMsg(msg: String) {
        Log.d(TAG, "debugMsg: $msg")
        //Toast.makeText(registrar.activity(), msg, Toast.LENGTH_LONG).show()
    }

    private fun generateFile(extension: String = ""): File {

        val ctx = registrar.activeContext().applicationContext

        var storePath = ""
        storePath = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            ctx.getExternalFilesDir(Environment.DIRECTORY_PICTURES)!!.absolutePath + File.separator + getApplicationName()
        } else {
            Environment.getExternalStorageDirectory().absolutePath + File.separator + getApplicationName()
        }

        Log.d(TAG, "files path: ${ctx.filesDir.absolutePath}\n ${Environment.getDataDirectory().absolutePath}")

        debugMsg("storePath：$storePath")

        val appDir = File(storePath)
        if (!appDir.exists()) {
            var created = appDir.mkdir()
            debugMsg("storePath created:$created")
        } else {
            debugMsg("storePath exists")
        }
        var fileName = System.currentTimeMillis().toString()
        if (extension.isNotEmpty()) {
            fileName += (".$extension")
        }
        return File(appDir, fileName)
    }

    private fun saveImageToGallery(bmp: Bitmap): String {
        val file = generateFile("png")
        val ctx = registrar.activeContext().applicationContext

        try {
            val fos = FileOutputStream(file)
            bmp.compress(Bitmap.CompressFormat.PNG, 60, fos)
            fos.flush()
            fos.close()
            val uri = Uri.fromFile(file)
            // notify gallery to show the image
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
                ctx.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri))
            } else {
                androidQSaveImage2Gallery(file)
            }

            return uri.toString()
        } catch (e: Exception) {
            e.printStackTrace()
            debugMsg(exceptionMsg(e))
        }
        return ""
    }

    private fun androidQSaveImage2Gallery(file: File) {

        val values = ContentValues()
        values.put(MediaStore.Images.Media.TITLE, file.name)
        values.put(MediaStore.Images.Media.DISPLAY_NAME, file.name)

        values.put(MediaStore.Images.Media.MIME_TYPE, "image/png")
        values.put(MediaStore.Images.Media.RELATIVE_PATH, "Pictures/${getApplicationName()}${File.separator}${file.name}")

        val ctx = registrar.activeContext().applicationContext
        val uri = ctx.contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)

        val descriptor = ctx.contentResolver.openFileDescriptor(uri!!, "w")
        val fileDescriptor = descriptor?.fileDescriptor

        val dataInputStream = FileInputStream(file)//ctx.openFileInput(file.absolutePath)

        val output = FileOutputStream(fileDescriptor)
        var buf = ByteArray(1024)
        var bytesRead: Int
        while (true) {
            bytesRead = dataInputStream.read(buf)
            if (bytesRead > 0) {
                output.write(buf, 0, bytesRead)
            } else {
                break
            }
        }
        dataInputStream.close()
        output.close()
    }


    private fun exceptionMsg(e: Exception): String {
        val msg = e.message
        //val stackTrace = e.stackTrace
        return "Exception: $msg ${e.localizedMessage}"
    }

    private fun saveFileToGallery(filePath: String): String {
        val context = registrar.activeContext().applicationContext
        return try {
            val originalFile = File(filePath)
            val file = generateFile(originalFile.extension)
            originalFile.copyTo(file)

            val uri = Uri.fromFile(file)
            context.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri))
            return uri.toString()
        } catch (e: IOException) {
            e.printStackTrace()
            ""
        }
    }

    private fun getApplicationName(): String {
        val context = registrar.activeContext().applicationContext
        var ai: ApplicationInfo? = null
        try {
            ai = context.packageManager.getApplicationInfo(context.packageName, 0)
        } catch (e: PackageManager.NameNotFoundException) {
        }
        var appName: String
        appName = if (ai != null) {
            val charSequence = context.packageManager.getApplicationLabel(ai)
            StringBuilder(charSequence.length).append(charSequence).toString()
        } else {
            "image_gallery_saver"
        }
        return appName
    }


}
