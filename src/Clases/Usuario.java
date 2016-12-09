/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Clases;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.StringTokenizer;
import javax.swing.JOptionPane;

/**
 *
 * @author Reymundo Tenorio
 */
public class Usuario {
    
    
public static ResultSet resultado;

public static void Agregar_Usuario(int ID, String Nombres, 
        String Apellidos, String Cedula, String Puesto, 
        String Recinto, String Privilegio){

    
    int j = 0;
    String NombreLogin = "" ;
    String NombreEmpleado = Nombres.trim().concat(" "+Apellidos).trim();
    
    StringTokenizer Usuario= new StringTokenizer(NombreEmpleado, " ");
                   while(Usuario.hasMoreTokens()){
                  if(j==2){
                      NombreLogin = NombreLogin.concat("_"+Usuario.nextToken());
                      break;
                     }  
                       if(j==1){
                           Usuario.nextToken();
                           j=2;
                       }
                       
                        if(j==0){
                    NombreLogin = Usuario.nextToken();
                    j=1;
                           
                       }
                        
                  
                     }
   
   
   NombreLogin = NombreLogin.concat(String.valueOf(ID));
 
   
        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Agregar_Usuario] (?,?,?,?,?,?,?)}");

                        consulta.setString(1, Nombres);
                        consulta.setString(2, Apellidos);
                        consulta.setString(3, Cedula);
                        consulta.setString(4, Puesto);
                        consulta.setString(5, Recinto);
                        consulta.setString(6, Privilegio);
                        consulta.setString(7, NombreLogin);
                     
                        
                        
                      
                        consulta.execute();
                        
                        
                        

         JOptionPane.showMessageDialog(null,"Datos del Usuario Guardado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }



        

    }

public static void RegistrarLogin(int ID, String NombreLogin,
        String Privilegio, String Contrasena){
    
    

    
     
     try{
  Statement Ejecutar = Conexion.con.createStatement();
  String CreateLogin = "Create Login "+NombreLogin+" with password = '"+Contrasena+"'";
  Ejecutar.executeUpdate(CreateLogin);
  JOptionPane.showMessageDialog(null, "Login Creado Correctamente");
  
    } catch (SQLException ex) {
          JOptionPane.showMessageDialog(null,ex.getMessage());  
         
    }
     
     try{
    Statement Ejecutar1 = Conexion.con.createStatement();
    String CrearUsuario = "sp_adduser "+NombreLogin+" , "+NombreLogin;
    Ejecutar1.executeUpdate(CrearUsuario);
  
    JOptionPane.showMessageDialog(null, "Usuario Creado Correctamente");
       } catch (SQLException ex) {
          JOptionPane.showMessageDialog(null,ex.getMessage());
    
    }
        
   Usuario.CambiarPrivilegio(ID, Privilegio, NombreLogin);
   
}

public static void RegistrarLoginSHA2_512(int ID, String NombreLogin,
        String Privilegio, String Contrasena){
    
    

        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[AgregarLoginSHA2_512] (?,?)}");

                        consulta.setString(1, NombreLogin);
                        consulta.setString(2, Contrasena);
                      
    
                        consulta.execute();
                        
                        
                        

         JOptionPane.showMessageDialog(null,"Login Creado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }
    
    
        
   Usuario.CambiarPrivilegio(ID, Privilegio, NombreLogin);
   
}

public static void DesactivarLogin(int ID, String NombreLogin){
    
     
    
  try{
    Statement Ejecutar1 = Conexion.con.createStatement();
    String BorrarUsuario = "Sp_Dropuser "+NombreLogin;
    Ejecutar1.executeUpdate(BorrarUsuario);
  
    JOptionPane.showMessageDialog(null, "Usuario Eliminado Correctamente");
       } catch (SQLException ex) {
          JOptionPane.showMessageDialog(null,ex.getMessage());
    
    }
   
     try{
  Statement Ejecutar = Conexion.con.createStatement();
  String CreateLogin = "Sp_DropLogin "+NombreLogin;
  Ejecutar.executeUpdate(CreateLogin);
  JOptionPane.showMessageDialog(null, "Login Creado Correctamente");
  
    } catch (SQLException ex) {
          JOptionPane.showMessageDialog(null,ex.getMessage());  
         
    }
     
 
}



public static void Agregar_ImagenUsuario(int ID_Usuario, String Ruta_Archivo){
    
     try {
         
         Statement Ejecutar = Conexion.con.createStatement();    
      
           String EXECString = "Exec [dbo].[Agregar_FotoUsuario] "+ID_Usuario+",'"+Ruta_Archivo+"'";
            Ejecutar.executeUpdate(EXECString);
   
         JOptionPane.showMessageDialog(null,"Foto Usuario Guardada Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

        } catch (SQLException ex) {
          
       JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

        }
    
    
}

public static void CambiarPrivilegio (int ID, String Privilegio, String NombreLogin){
    
    
       if("Administrador".equals(Privilegio)){
    

    
      try{
    Statement Ejecutar2 = Conexion.con.createStatement();
    String AgregarRole= "sp_addrolemember Administrador , "+NombreLogin;
    Ejecutar2.executeUpdate(AgregarRole);
    JOptionPane.showMessageDialog(null, "Usuario Agregado Al Rol Administrador Correctamente");  
       } catch (SQLException ex) {
         JOptionPane.showMessageDialog(null,ex.getMessage());
           }
      
      
      try{
          
         CallableStatement consultac = Conexion.con.prepareCall("{call [dbo].[Privilegios] (?,?)}");
        
         consultac.setInt(1, ID);
         consultac.setString(2, Privilegio);
         
         consultac.execute();
         
        } catch (SQLException ex) {
         JOptionPane.showMessageDialog(null,ex.getMessage());
           }
}

if("Standard".equals(Privilegio)){
 

      try{
    Statement Ejecutar3 = Conexion.con.createStatement();
    String AgregarRole= "sp_addrolemember Standard , "+NombreLogin;
    Ejecutar3.executeUpdate(AgregarRole);
    JOptionPane.showMessageDialog(null, "Usuario Agregado Al Rol Público Correctamente");
       } catch (SQLException ex) {
          JOptionPane.showMessageDialog(null,ex.getMessage());
       }

       
      try{
          
         CallableStatement consultac = Conexion.con.prepareCall("{call [dbo].[Privilegios] (?,?)}");
        
         consultac.setInt(1, ID);
         consultac.setString(2, Privilegio);
         
         consultac.execute();
         
        } catch (SQLException ex) {
         JOptionPane.showMessageDialog(null,ex.getMessage());
           }
}
}

public static void Actualizar_Usuario(int ID, String Nombres, 
        String Apellidos, String Cedula, String Puesto, 
        String Recinto, String Privilegio, String NombreLogin){

    
    
        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Actualizar_Usuario]  (?,?,?,?,?,?,?,?) }");

                        consulta.setInt(1,ID);
                        consulta.setString(2, Nombres);
                        consulta.setString(3, Apellidos);
                        consulta.setString(4, Cedula);
                        consulta.setString(5, Puesto);
                        consulta.setString(6, Recinto);
                        consulta.setString(7, Privilegio);
                        consulta.setString(8, NombreLogin);
                     
                        
                        
                       

                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Datos del Usuario Actualizados Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

        } catch (SQLException ex) {

        JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

        }
}
public static void Activar_Desactivar_Usuario(int ID, String Contrasena){
  
    try{
       
        String NombreLogin = null;
        String Privilegio = null;
       
         
            resultado = Conexion.consulta("Select [NombreLogin] from [dbo].[Usuarios] where [ID_Usuarios] = "+ID);
            while(resultado.next()){
              NombreLogin = resultado.getString(1);
            } 
            
               resultado = Conexion.consulta("Select [Privilegio_Usuario] from [dbo].[Usuarios] where [ID_Usuarios] = "+ID);
            while(resultado.next()){
              Privilegio = resultado.getString(1);
            }  
                
        
            String estado = null;
            resultado = Conexion.consulta("Select [Estado_Usuario] from [dbo].[Usuarios] where [ID_Usuarios] = "+ID);
            while(resultado.next()){

            estado = resultado.getString(1);
            }
            
            if("Activo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Desactivar_Usuario] (?)}");

               consulta.setInt(1, ID);
               consulta.execute();
      JOptionPane.showMessageDialog(null,"Estudiante Desactivado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
          
      Usuario.DesactivarLogin(ID, NombreLogin);
        
            }
            
            if("Inactivo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Activar_Usuario] (?)}");

               consulta.setInt(1, ID);
               consulta.execute();
      JOptionPane.showMessageDialog(null,"Estudiante Activado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
           
        Usuario.RegistrarLogin(ID, NombreLogin, Privilegio, Contrasena);
        
      
            }
            
  
    }catch(SQLException ex){

          JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

    }
}
    
}
