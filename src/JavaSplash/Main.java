package JavaSplash;

import java.io.IOException;
import java.net.ServerSocket;
import javax.swing.JOptionPane;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;


/**
 *
 * @author Reymundo Tenorio
 */
public class Main {

public static ServerSocket serverSocket;
    public static void main(String[] args) {


      
     boolean Ejecutando = false;

    try {
      serverSocket = new ServerSocket(55555);
    } catch (IOException ex) {
         Ejecutando = true;
        
    }
    
    if(Ejecutando==true){
    
        JOptionPane.showMessageDialog(null, "El Programa Ya Está En Ejecución En Otro Proceso","Error",JOptionPane.ERROR_MESSAGE);
         System.exit(0);
    }
           
                 try 
    {
     
UIManager.setLookAndFeel( new com.nilo.plaf.nimrod.NimRODLookAndFeel());
        

	      
    } catch (UnsupportedLookAndFeelException e) 
    {
            JOptionPane.showMessageDialog(null, "Error Al Iniciar Look and Feel","Error",JOptionPane.ERROR_MESSAGE);
    }
                 
        new ScreenSplash().animar();   
        
        
    }

}
