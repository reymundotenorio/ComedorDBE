
package Clases;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

public class Trabajador {

public static ResultSet resultado;

public static void Agregar_Trabajador(String NoCarnet, String Nombres, 
        String Apellidos, String Cedula, String Sexo, String Puesto){

    
 
        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Agregar_Trabajador] (?,?,?,?,?,?)}");

                
                        consulta.setString(1, NoCarnet);
                        consulta.setString(2, Nombres);
                        consulta.setString(3, Apellidos);
                        consulta.setString(4, Cedula);
                        consulta.setString(5, Sexo);
                        consulta.setString(6, Puesto);
                        
                        
                      
                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Datos del Trabajador Guardado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }



        

    }


public static void Agregar_ImagenTrabajador(int ID_Trabajador, String Ruta_Archivo){
    
     try {
         
         Statement Ejecutar = Conexion.con.createStatement();    
      
           String EXECString = "Exec [dbo].[Agregar_FotoTrabajador] "+ID_Trabajador+",'"+Ruta_Archivo+"'";
            Ejecutar.executeUpdate(EXECString);
   
         JOptionPane.showMessageDialog(null,"Foto Trabajador Guardada Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

        } catch (SQLException ex) {
          
       JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

        }
    
    
}

public static void Actualizar_Trabajador(int ID, String NoCarnet, String Nombres, 
        String Apellidos, String Cedula, String Sexo, String Puesto ){
   
        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Actualizar_Trabajador] (?,?,?,?,?,?,?) }");

                        consulta.setInt(1,ID);
                        consulta.setString(2, NoCarnet);
                        consulta.setString(3, Nombres);
                        consulta.setString(4, Apellidos);
                        consulta.setString(5, Cedula);
                        consulta.setString(6, Sexo);
                        consulta.setString(7, Puesto);
                       

                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Datos del Trabajador Actualizados Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

//        } catch (SQLException ex) {
//
//        JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
//
//        }
}   catch (SQLException ex) {
        Logger.getLogger(Trabajador.class.getName()).log(Level.SEVERE, null, ex);
    }
}

public static void Activar_Desactivar_Trabajador(int ID){
  
    try{
        
            String estado = null;
            resultado = Conexion.consulta("Select [Estado_Trabajador] from [dbo].[Trabajador] where [ID_Trabajador] = "+ID);
            while(resultado.next()){

            estado = resultado.getString(1);
            }
            
            if("Activo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Desactivar_Trabajador] (?)}");

               consulta.setInt(1, ID);
               consulta.execute();
      JOptionPane.showMessageDialog(null,"Trabajador Desactivado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
          
            }
            
            if("Inactivo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Activar_Trabajador] (?)}");

               consulta.setInt(1, ID);
               consulta.execute();
      JOptionPane.showMessageDialog(null,"Trabajador Activado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
            }
            
  
    }catch(SQLException ex){

          JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

    }
}
}
