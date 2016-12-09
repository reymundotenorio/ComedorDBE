/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Clases;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Reymundo Tenorio
 */
public class BecaAlimenticia {
    
    
public static ResultSet resultado;

public static void Agregar_BecaAlimenticia(int ID_Estudiante){
   
    try{
  
        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[IngresarBeca_Estudiante] (?)}");

        consulta.setInt(1, ID_Estudiante);
                        
        consulta.execute();

         JOptionPane.showMessageDialog(null,"Estudiante Agregado a Beca Alimenticia Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }



        

    }

  
  
public static void Activar_Desactivar_BecaAlimenticia(int ID_BecaAlimenticia){
  
    try{
        
            String estado = null;
            resultado = Conexion.consulta("Select [Estado_Beca] from [dbo].[BecaAlimenticia] where  [ID_BecaAlimenticia] = "+ID_BecaAlimenticia);
            while(resultado.next()){

            estado = resultado.getString(1);
            }
            
            if("Activo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[DesactivarBeca_Estudiante] (?)}");

               consulta.setInt(1, ID_BecaAlimenticia);
               consulta.execute();
               
      JOptionPane.showMessageDialog(null,"Beca Alimenticia de Estudiante Desactivada Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
          
            }
            
            if("Inactivo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[ActivarBeca_Estudiante] (?)}");

               consulta.setInt(1, ID_BecaAlimenticia);
               consulta.execute();
      JOptionPane.showMessageDialog(null,"Beca Alimenticia de Estudiante Activada Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
            }
            
  
    }catch(SQLException ex){

          JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

    }
}
    
}
