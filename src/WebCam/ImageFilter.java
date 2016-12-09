package WebCam;


import javax.swing.filechooser.FileFilter;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author FAMILIA MEZA MEZA
 */

import java.io.File;

public class ImageFilter extends FileFilter {
    final static String jpg = "jpg";
    final static String jpeg = "jpeg";
    final static String png = "png";
    final static String bmp = "bmp";
    final static String gif = "gif";
    

    @Override
    public boolean accept(File f) {
        if (f.isDirectory()) {
            return true;
        }

        String s = f.getName();
        int i = s.lastIndexOf('.');

        if (i > 0 &&  i < s.length() - 1) {
            String extension = s.substring(i+1).toLowerCase();
            if (jpg.equals(extension)==true ^ jpeg.equals(extension)==true ^ png.equals(extension)==true ^ bmp.equals(extension)==true ^ gif.equals(extension)==true) {
                    return true;
            } else {
                return false;
            }
        }

        return false;
    }
    
    // The description of this filter
    @Override
    public String getDescription() {
        return "Solo Archivos de Imágen";
    }
}
