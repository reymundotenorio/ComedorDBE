/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package WebCam;

import Principal.EstudianteP;
import Principal.TrabajadorP;
import com.googlecode.javacv.FrameGrabber;
import com.googlecode.javacv.OpenCVFrameGrabber;
import com.googlecode.javacv.cpp.opencv_core;
import static com.googlecode.javacv.cpp.opencv_core.CV_AA;
import static com.googlecode.javacv.cpp.opencv_core.cvClearMemStorage;
import static com.googlecode.javacv.cpp.opencv_core.cvFlip;
import static com.googlecode.javacv.cpp.opencv_core.cvGetSeqElem;
import static com.googlecode.javacv.cpp.opencv_core.cvLoad;
import static com.googlecode.javacv.cpp.opencv_core.cvPoint;
import static com.googlecode.javacv.cpp.opencv_core.cvRectangle;
import static com.googlecode.javacv.cpp.opencv_highgui.cvSaveImage;
import com.googlecode.javacv.cpp.opencv_objdetect;
import static com.googlecode.javacv.cpp.opencv_objdetect.CV_HAAR_DO_CANNY_PRUNING;
import static com.googlecode.javacv.cpp.opencv_objdetect.cvHaarDetectObjects;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.File;
import java.io.IOException;
import static java.lang.System.currentTimeMillis;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.media.Manager;
import javax.media.NoPlayerException;
import javax.media.Player;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;

/**
 *
 * @author Reymundo Tenorio
 */
public final class WebCam extends  javax.swing.JFrame implements MouseListener {

    /**
     * Creates new form WebCam
     * @param Device
     */
    public WebCam(int Device) {
        
      this.setUndecorated(true);
         
      WC = new WebCamCap();
      WC.setWebCam(this);
      WC.setCamara(Device);
//      WC.setDispositivos(Dispositivos);
      
      Runnable Camera = WC;
      
     
      Thread Cam = new Thread (Camera);
      Cam.start();
        
          if(!Home.exists()){
            Home.mkdir();
        }
        
        ActualizarExplorer();
        initComponents();
//        
         LoadFilesFolder();
         PExplorer.setLayout(new GridLayout(f,5,1,10));
        
         
    }   
   
    public void ActualizarExplorer(){
        int c=0;
        ImageFilter IF=new ImageFilter();
        for (File listFile : Home.listFiles()) {
            if (IF.accept(listFile)) {
                c++;
            }
        }
        f=((int)c/5)+4;
//        
    }
    
    private File Imgs[]=null;
    private int f=1;
    private ImageIcon IIcons[]=null;
    private JLabel Foto[]=null;
    private JPanel IPanel[]=null;
    private EstudianteP Estudiantes;
    private TrabajadorP Trabajadores;
//    private Dispositivos Dispositivos;
//
//    public void setDispositivos(Dispositivos Dispositivos) {
//        this.Dispositivos = Dispositivos;
//    }
    

    public void setEstudiantes(EstudianteP Estudiantes) {
        this.Estudiantes = Estudiantes;
    }

    public void setTrabajadores(TrabajadorP Trabajadores) {
        this.Trabajadores = Trabajadores;
    }
    
     private final File Home=new File("Capturas");

    
    
      public void LoadFilesFolder(){
        PExplorer.removeAll();
        
        int c=0;
        ImageFilter IF=new ImageFilter();
        for (File listFile : Home.listFiles()) {
            if (IF.accept(listFile)) {
                c++;
            }
        }
        
        
        Imgs=new File[c]; int k=0;
        for (File listFile : Home.listFiles()) {
            if (IF.accept(listFile)) {
                Imgs[k] = new File(listFile.getAbsolutePath());
                k++;
            }
        }
        
        
        if(Imgs!=null){
            IIcons=new ImageIcon[Imgs.length];
            ImageIcon thumbnail = null;
            Foto=new JLabel[c];
            IPanel=new JPanel[c];
            int p=5;
            for(int i=0; i<Imgs.length; i++){
                
                IIcons[i]=new ImageIcon(Imgs[i].getAbsolutePath());
                thumbnail = new ImageIcon(IIcons[i].getImage().
                                      getScaledInstance(220,220,
                                                        Image.SCALE_DEFAULT));
                IIcons[i]=thumbnail;
                IPanel[i]=new JPanel();
                Foto[i]=new JLabel();
                Foto[i].setIcon(thumbnail);
                Foto[i].setBounds(p,5,120,125);
                Foto[i].addMouseListener(this);
                p=p+130;
                PExplorer.add(Foto[i]);
                Foto[i].setToolTipText(Imgs[i].getName());
                
                
            }
            
        }
        
        
    }
    
    
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        Info = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        Contenedor = new javax.swing.JPanel();
        Explorer = new javax.swing.JScrollPane();
        PExplorer = new javax.swing.JPanel();
        ViewWebCam = new javax.swing.JPanel();
        lblPic = new javax.swing.JLabel();
        PanelButton = new javax.swing.JPanel();
        btnCapture = new javax.swing.JButton();
        chDetectarRostro = new javax.swing.JCheckBox();
        chAutoRostro = new javax.swing.JCheckBox();
        btnCapture1 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("WebCam Capture - Reymundo Tenorio");
        setExtendedState(javax.swing.JFrame.MAXIMIZED_BOTH);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                formWindowClosing(evt);
            }
            public void windowOpened(java.awt.event.WindowEvent evt) {
                formWindowOpened(evt);
            }
        });
        getContentPane().setLayout(new java.awt.BorderLayout(10, 5));

        Info.setBackground(new java.awt.Color(0, 102, 153));
        java.awt.FlowLayout flowLayout1 = new java.awt.FlowLayout(java.awt.FlowLayout.RIGHT);
        flowLayout1.setAlignOnBaseline(true);
        Info.setLayout(flowLayout1);

        jLabel1.setFont(new java.awt.Font("Tahoma", 1, 12)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(255, 255, 255));
        jLabel1.setText("WebCam Capture 1.0 ® - Reymundo Tenorio");
        Info.add(jLabel1);

        getContentPane().add(Info, java.awt.BorderLayout.PAGE_START);

        Contenedor.setBackground(new java.awt.Color(0, 153, 204));
        Contenedor.setLayout(new java.awt.BorderLayout());

        Explorer.setBackground(new java.awt.Color(0, 102, 153));
        Explorer.setBorder(javax.swing.BorderFactory.createTitledBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.LOWERED), "Explorador de Fotografías", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 1, 14), new java.awt.Color(255, 255, 255))); // NOI18N

        PExplorer.setBackground(new java.awt.Color(0, 153, 204));
        PExplorer.setToolTipText("Doble Click En La Imagen Para Ver En Tamaño Real.");
        PExplorer.setMaximumSize(new java.awt.Dimension(640, 3000));
        PExplorer.setPreferredSize(new java.awt.Dimension(640, f*175));
        PExplorer.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                PExplorerMouseClicked(evt);
            }
        });

        javax.swing.GroupLayout PExplorerLayout = new javax.swing.GroupLayout(PExplorer);
        PExplorer.setLayout(PExplorerLayout);
        PExplorerLayout.setHorizontalGroup(
            PExplorerLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 10, Short.MAX_VALUE)
        );
        PExplorerLayout.setVerticalGroup(
            PExplorerLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 224, Short.MAX_VALUE)
        );

        Explorer.setViewportView(PExplorer);

        Contenedor.add(Explorer, java.awt.BorderLayout.EAST);

        ViewWebCam.setBackground(new java.awt.Color(0, 153, 204));
        ViewWebCam.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createCompoundBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.RAISED), javax.swing.BorderFactory.createEtchedBorder()), "Vista Previa", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 1, 14), new java.awt.Color(255, 255, 255))); // NOI18N
        ViewWebCam.setLayout(new java.awt.GridBagLayout());
        ViewWebCam.add(lblPic, new java.awt.GridBagConstraints());

        Contenedor.add(ViewWebCam, java.awt.BorderLayout.CENTER);

        PanelButton.setBackground(new java.awt.Color(0, 102, 153));
        PanelButton.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Opciones", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 1, 14), new java.awt.Color(255, 255, 255))); // NOI18N

        btnCapture.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        btnCapture.setForeground(new java.awt.Color(255, 255, 255));
        btnCapture.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Imagenes/Camara.png"))); // NOI18N
        btnCapture.setMnemonic('C');
        btnCapture.setText("Capturar");
        btnCapture.setToolTipText("Capturar Fotografía");
        btnCapture.setContentAreaFilled(false);
        btnCapture.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        btnCapture.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        btnCapture.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCaptureActionPerformed(evt);
            }
        });
        PanelButton.add(btnCapture);

        chDetectarRostro.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        chDetectarRostro.setForeground(new java.awt.Color(255, 255, 255));
        chDetectarRostro.setMnemonic('D');
        chDetectarRostro.setText("Activar Detección de Rostros");
        chDetectarRostro.setToolTipText("Detección de Rostros");
        chDetectarRostro.setContentAreaFilled(false);
        chDetectarRostro.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        chDetectarRostro.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Imagenes/FaceDetection.png"))); // NOI18N
        chDetectarRostro.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        chDetectarRostro.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                chDetectarRostroStateChanged(evt);
            }
        });
        PanelButton.add(chDetectarRostro);

        chAutoRostro.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        chAutoRostro.setForeground(new java.awt.Color(255, 255, 255));
        chAutoRostro.setMnemonic('A');
        chAutoRostro.setText("Activar Autocapturar");
        chAutoRostro.setToolTipText("Autocapturar al Detectar Rostro");
        chAutoRostro.setContentAreaFilled(false);
        chAutoRostro.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        chAutoRostro.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Imagenes/FaceAuto.png"))); // NOI18N
        chAutoRostro.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        chAutoRostro.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                chAutoRostroStateChanged(evt);
            }
        });
        PanelButton.add(chAutoRostro);

        btnCapture1.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        btnCapture1.setForeground(new java.awt.Color(255, 255, 255));
        btnCapture1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Imagenes/Exit.png"))); // NOI18N
        btnCapture1.setMnemonic('S');
        btnCapture1.setText("Salir");
        btnCapture1.setToolTipText("Salir");
        btnCapture1.setContentAreaFilled(false);
        btnCapture1.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        btnCapture1.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        btnCapture1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCapture1ActionPerformed(evt);
            }
        });
        PanelButton.add(btnCapture1);

        Contenedor.add(PanelButton, java.awt.BorderLayout.PAGE_END);

        getContentPane().add(Contenedor, java.awt.BorderLayout.CENTER);

        setSize(new java.awt.Dimension(759, 431));
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void PExplorerMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_PExplorerMouseClicked

    }//GEN-LAST:event_PExplorerMouseClicked

    
   public void VideoCapture(Image imagen) throws IOException{
      
        ViewWebCam.removeAll();
        
        ImageIcon icon = new ImageIcon(imagen);
        lblPic.setIcon(icon);
        
        ViewWebCam.add(lblPic);
        ViewWebCam.updateUI();  
 
   }
  
  
   private final WebCamCap WC; 
   private int Camara;
  

    

    public void setCamara(int Camara) {
        this.Camara = Camara;
    }
   
    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
    
      this.setResizable(false);
      this.toFront();
     
// TODO add your handling code here:
    }//GEN-LAST:event_formWindowOpened

    private void formWindowClosing(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowClosing
  
     WC.Apagar();
     // TODO add your handling code here:
    }//GEN-LAST:event_formWindowClosing

    private void btnCaptureActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCaptureActionPerformed
        try {
            WC.GuardarImagen();
        }catch(IOException ex){

        }
        // TODO add your handling code here:
    }//GEN-LAST:event_btnCaptureActionPerformed

    private void chDetectarRostroStateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_chDetectarRostroStateChanged

if(chDetectarRostro.isSelected()){
    this.WC.setFace(true);
    chDetectarRostro.setText("Desactivar Detección de Rostros");
}
else{
    this.WC.setFace(false);
    chDetectarRostro.setText("Activar Detección de Rostros");
}

// TODO add your handling code here:
    }//GEN-LAST:event_chDetectarRostroStateChanged

    private void btnCapture1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCapture1ActionPerformed
Cerrar();        // TODO add your handling code here:
    }//GEN-LAST:event_btnCapture1ActionPerformed

    private void chAutoRostroStateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_chAutoRostroStateChanged
    
if(chAutoRostro.isSelected()){
    chAutoRostro.setText("Desactivar Autocaptura");
    this.WC.setAuto(true);
    this.WC.setFace(true);
    
}
else{
    
    chAutoRostro.setText("Activar Autocaptura");
    this.WC.setAuto(false);
    if(chDetectarRostro.isSelected() == false){
    this.WC.setFace(false);
    }
}    // TODO add your handling code here:
    }//GEN-LAST:event_chAutoRostroStateChanged

    public void Cerrar(){
        
       if(Estudiantes!=null){
       this.Estudiantes.setVisible(true);
      }
      if(Trabajadores != null ){
      this.Trabajadores.setVisible(true);
      }
      
      WC.Apagar(); 
      
    }
     
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(WebCam.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                new WebCam(0).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel Contenedor;
    private javax.swing.JScrollPane Explorer;
    private javax.swing.JPanel Info;
    private javax.swing.JPanel PExplorer;
    private javax.swing.JPanel PanelButton;
    private javax.swing.JPanel ViewWebCam;
    private javax.swing.JButton btnCapture;
    private javax.swing.JButton btnCapture1;
    private javax.swing.JCheckBox chAutoRostro;
    private javax.swing.JCheckBox chDetectarRostro;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel lblPic;
    // End of variables declaration//GEN-END:variables

    @Override
    public void mouseClicked(MouseEvent e) {
      if(e.getClickCount()==2){
        JLabel E=(JLabel)e.getSource();
        for(int i=0;i<Foto.length;i++){
            if(E.equals(Foto[i])){
         
                ViewImageFrame VIF=new ViewImageFrame(this,true,Imgs[i].getAbsolutePath());
                VIF.setEstudiantes(Estudiantes);  
                VIF.setTrabajadores(Trabajadores);
                VIF.setWebCam(this);
                VIF.setVisible(true);
            }    
        }
        }
    }

    @Override
    public void mousePressed(MouseEvent e) {
   //     throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void mouseReleased(MouseEvent e) {
   //     throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void mouseEntered(MouseEvent e) {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void mouseExited(MouseEvent e) {
    //    throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
 public class WebCamCap implements Runnable {
  
    private WebCam WebCam;
    private  boolean Flag;
    private opencv_core.IplImage img;
    private String XML_FILE = "\\haarcascade_frontalface_default.xml";
    private boolean Face;
    private boolean Auto;
    private int Camara;
    

//    private Dispositivos Dispositivos;
//
//        public void setDispositivos(Dispositivos Dispositivos) {
//            this.Dispositivos = Dispositivos;
//        }
        public void setAuto(boolean Auto) {
            this.Auto = Auto;
        }

    
        public void setFace(boolean Face) {
            this.Face = Face;
        }
    

        public void setWebCam(WebCam WebCam) {
            this.WebCam = WebCam;
            this.Flag = true;
            this.Face = false;
            this.Auto = false;
            this.Camara = 1;
        }

        public void setCamara(int Camara) {
            this.Camara = Camara;
        }
     
        public void Apagar() {
        this.Flag = false;
        this.Face = false;
        this.Auto = false;
//        this.Dispositivos.dispose();
        this.WebCam.dispose();       
       }
 
        public void GuardarImagen() throws IOException{
       
            
    File File = new File("");
    String Ruta = File.getAbsolutePath()+"\\Capturas\\";
 
    Timestamp i = new java.sql.Timestamp(currentTimeMillis());
//    int Dia, Mes, Ano, Hora, Mins, Seg, Nanos, Zone;
    int Nanos;
//    
//    Dia = i.getDay();
//    Mes = i.getMonth()+1;
//    Ano = i.getYear();
//    Hora = i.getHours();
//    Mins = i.getMinutes();
//    Seg = i.getSeconds();

//    Zone = i.getTimezoneOffset();
    
//   String Pic = "Capture_"+Dia+"_"+Mes+"_"+Ano+"_"+Hora+"_"+Mins+"_"+Seg+
//           "_"+Nanos+"_"+Zone +".jpg" ;
//   String Path = Ruta+Pic;
    
  Nanos = i.getNanos(); 
  long Time = i.getTime();
   
  SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh_mm_ss a");
  Date Date = new Date(Time);
  String Fecha = sdf.format(Date);
    String AM_PM  = Fecha.substring(Fecha.length()-2, Fecha.length());
    Fecha = Fecha.substring(0,Fecha.length()-3);
    
     String Path = Ruta.concat("Capture_").concat(Fecha).
             concat(String.valueOf(Nanos)).concat("_"+AM_PM).concat(".jpg");
           
        
    cvSaveImage(Path, img);
   
  Player play = null; 
       try {
        play = Manager.createPlayer(new File("Flash.mp3").toURL());
        } catch (IOException | NoPlayerException ex) {
      
        }
        play.start(); 
    
   
    
    if(Estudiantes != null){
            
              Estudiantes.Foto(Path);
              Estudiantes.setFoto();
              Estudiantes.setVisible(true);
                try {
                 Thread.sleep(500);
             } catch (InterruptedException ex) {
               }
              this.WebCam.Cerrar();
     }
     if(Trabajadores != null){
              Trabajadores.Foto(Path);
              Trabajadores.setFoto();
              Trabajadores.setVisible(true);
                try {
                 Thread.sleep(500);
             } catch (InterruptedException ex) {
               }
              this.WebCam.Cerrar();
     }
           
    ActualizarExplorer();
    LoadFilesFolder();
        
      try {
                 Thread.sleep(1000);
             } catch (InterruptedException ex) {
               }
      
//    this.Apagar();
//    this.WebCam.Cerrar();
    
    play.stop();
 
        }
       
           
        @Override
        public synchronized void run() {
     
        while(Flag){        
            
     File File = new File("");
     XML_FILE = File.getAbsolutePath()+XML_FILE;   
     FrameGrabber grabber = new OpenCVFrameGrabber(Camara);  
      
     try {      
       
      grabber.start();   
  
      WebCam.lblPic.setSize(grabber.getImageWidth(), grabber.getImageHeight());
   
     int Total_Faces = 0;
     
      while (Flag) {

       
          
       img = grabber.grab();
       
 
       if (img != null) {      
        
         cvFlip(img, img, 1);// l-r = 90_degrees_steps_anti_clockwise;
         
         if(Face){
        

           
            
		opencv_objdetect.CvHaarClassifierCascade cascade = new 
		opencv_objdetect.CvHaarClassifierCascade(cvLoad(XML_FILE));
                
		opencv_core.CvMemStorage storage = opencv_core.CvMemStorage.create();
		opencv_core.CvSeq sign = cvHaarDetectObjects(
				img,
				cascade,
				storage,
				1.5,
				3,
				CV_HAAR_DO_CANNY_PRUNING);

		cvClearMemStorage(storage);

		Total_Faces = sign.total();		

		for(int i = 0; i < Total_Faces; i++){
			opencv_core.CvRect r = new opencv_core.CvRect(cvGetSeqElem(sign, i));
			cvRectangle (   img,
					cvPoint(r.x(), r.y()),
					cvPoint(r.width() + r.x(), r.height() + r.y()),
					opencv_core.CvScalar.CYAN,
					1,
					CV_AA,
					0 );

		}

         }
    
          Image imagen;
          imagen = img.getBufferedImage();

 if(Auto == true && Total_Faces > 0){
 
     GuardarImagen();
 

}
           try {
               WebCam.VideoCapture(imagen);
           } catch (IOException ex) {
            }
        
       }
       }
      
      
      if(Flag == false){
          grabber.stop();
      }
      }
     catch (FrameGrabber.Exception | IOException e) {
     }
     
        }
     
     
        }
     
}
  
  
  
}


