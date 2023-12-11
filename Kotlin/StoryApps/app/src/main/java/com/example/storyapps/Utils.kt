package com.example.storyapps

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import androidx.exifinterface.media.ExifInterface
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream

fun File.reduceFileImage(): File {
    val file = this
    val bitmap = BitmapFactory.decodeFile(file.path)?.getRotatedBitmap(file)

    if (bitmap != null) {
        var compressQuality = 100
        var streamLength: Int
        do {
            val bmpStream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.JPEG, compressQuality, bmpStream)
            val bmpPicByteArray = bmpStream.toByteArray()
            streamLength = bmpPicByteArray.size
            compressQuality -= 1
        } while (streamLength > MAXIMAL_SIZE)
        bitmap.compress(Bitmap.CompressFormat.JPEG, compressQuality, FileOutputStream(file))
    } else {
        return file
    }
    return file
}

fun Bitmap.getRotatedBitmap(file: File): Bitmap? {
    val exif = ExifInterface(file.path)
    val rotation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL)
    val rotationInDegrees = exifToDegrees(rotation)
    val matrix = Matrix()
    if (rotation != 0) {
        matrix.preRotate(rotationInDegrees.toFloat())
    }
    return Bitmap.createBitmap(this, 0, 0, width, height, matrix, true)
}

private fun exifToDegrees(exifOrientation: Int): Int {
    return when (exifOrientation) {
        ExifInterface.ORIENTATION_ROTATE_90 -> 90
        ExifInterface.ORIENTATION_ROTATE_180 -> 180
        ExifInterface.ORIENTATION_ROTATE_270 -> 270
        else -> 0
    }
}

const val MAXIMAL_SIZE = 1000000