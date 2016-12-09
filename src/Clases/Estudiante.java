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
public class Estudiante {
    
    
public static ResultSet resultado;

public static void Agregar_Estudiante(String NoCarnet, String Nombres, 
        String Apellidos, String FechaNacimiento, String Sexo, String Facultad, String Carrera){

    
    
    String  DiaC = null, MesC = null, AnoC = null;
    
    int j=0;
    
  
    //10-02-2014
     StringTokenizer FC = new StringTokenizer(FechaNacimiento, "-");
                  
     while(FC.hasMoreTokens()){
         
                  if(j==2){
                      AnoC = FC.nextToken();
                      break;
                  }
                  
                   if(j==1){
                      
                      MesC= FC.nextToken();
                      j++;
                    }
                         
                    if(j==0){
                      
                      DiaC = FC.nextToken();
                     j++;
                    }
                    
                     }
                      
 int MesCo = Integer.parseInt(MesC);
 int DiaCo = Integer.parseInt(DiaC);
 int AnoCo = Integer.parseInt(AnoC);
 
        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Agregar_Estudiante] (?,?,?,?,?,?,?,?,?)}");

                
                        consulta.setString(1, NoCarnet);
                        consulta.setString(2, Nombres);
                        consulta.setString(3, Apellidos);
                        consulta.setString(4, Sexo);
                        consulta.setString(5, Facultad);
                        consulta.setString(6, Carrera);
                        consulta.setInt(7, DiaCo);
                        consulta.setInt(8, MesCo);
                        consulta.setInt(9, AnoCo);
                        
                        
                      
                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Datos del Estudiante Guardado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }



        

    }


public static void Agregar_ImagenEstudiante(int ID_Estudiante, String Ruta_Archivo){
    
     try {
         
         Statement Ejecutar = Conexion.con.createStatement();    
      
           String EXECString = "Exec [dbo].[Agregar_FotoEstudiante] "+ID_Estudiante+",'"+Ruta_Archivo+"'";
            Ejecutar.executeUpdate(EXECString);
   
         JOptionPane.showMessageDialog(null,"Foto Estudiante Guardada Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

        } catch (SQLException ex) {
          
       JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

        }
    
}

public static void Actualizar_Estudiante(int ID, String NoCarnet, String Nombres, 
        String Apellidos, String FechaNacimiento, String Sexo, String Facultad, String Carrera ){
   
    
     String  DiaC = null, MesC = null, AnoC = null;
    
    int j=0;
    
  
    //10-02-2014
     StringTokenizer FC = new StringTokenizer(FechaNacimiento, "-");
                  
     while(FC.hasMoreTokens()){
         
                  if(j==2){
                      AnoC = FC.nextToken();
                      break;
                  }
                  
                   if(j==1){
                      
                      MesC= FC.nextToken();
                      j++;
                    }
                         
                    if(j==0){
                      
                      DiaC = FC.nextToken();
                     j++;
                    }
                    
                     }
                      
 int MesCo = Integer.parseInt(MesC);
 int DiaCo = Integer.parseInt(DiaC);
 int AnoCo = Integer.parseInt(AnoC);
 
    
    
        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Actualizar_Estudiante] (?,?,?,?,?,?,?,?,?,?) }");

                        consulta.setInt(1,ID);
                        consulta.setString(2, NoCarnet);
                        consulta.setString(3, Nombres);
                        consulta.setString(4, Apellidos);
                        consulta.setString(5, Sexo);
                        consulta.setString(6, Facultad);
                        consulta.setString(7, Carrera);
                        consulta.setInt(8, DiaCo);
                        consulta.setInt(9, MesCo);
                        consulta.setInt(10, AnoCo);
                        
                       

                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Datos del Estudiante Actualizados Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

        } catch (SQLException ex) {

        JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

        }
}
public static void Activar_Desactivar_Estudiante(int ID){
  
    try{
        
            String estado = null;
            resultado = Conexion.consulta("Select [Estado_Estudiante] from [dbo].[Estudiante] where [ID_Estudiante] = "+ID);
            while(resultado.next()){

            estado = resultado.getString(1);
            }
            
            if("Activo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Desactivar_Estudiante] (?)}");

               consulta.setInt(1, ID);
               consulta.execute();
      JOptionPane.showMessageDialog(null,"Estudiante Desactivado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
          
            }
            
            if("Inactivo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[Activar_Estudiante] (?)}");

               consulta.setInt(1, ID);
               consulta.execute();
      JOptionPane.showMessageDialog(null,"Estudiante Activado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
            }
            
  
    }catch(SQLException ex){

          JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

    }
}
    
}
