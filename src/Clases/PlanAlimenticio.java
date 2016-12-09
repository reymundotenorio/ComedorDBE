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
public class PlanAlimenticio {
    
    
public static ResultSet resultado;

public static void Agregar_PlanAlimenticio(int ID_Trabajador){
   
    try{
  
        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[IngresarPlan_Trabajador] (?)}");

        consulta.setInt(1, ID_Trabajador);
                        
        consulta.execute();

         JOptionPane.showMessageDialog(null,"Trabajador Agregado a Plan Alimenticio Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }        

    }

  
  
public static void Activar_Desactivar_PlanAlimenticio(int ID_PlanAlimenticio){
  
    try{
        
            String estado = null;
            resultado = Conexion.consulta("Select [Estado_Plan] from [dbo].[PlanAlimenticio] where [ID_PlanAlimenticio] = "+ID_PlanAlimenticio);
            while(resultado.next()){

            estado = resultado.getString(1);
            }
            
            if("Activo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[DesactivarPlan_Trabajador] (?)}");

               consulta.setInt(1, ID_PlanAlimenticio);
               consulta.execute();
               
      JOptionPane.showMessageDialog(null,"Plan Alimenticio de Trabajador Desactivado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
          
            }
            
            if("Inactivo".equals(estado)){
               CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[ActivarPlan_Trabajador] (?)}");

               consulta.setInt(1, ID_PlanAlimenticio);
               consulta.execute();
      JOptionPane.showMessageDialog(null,"Plan Alimenticio de Trabajador Activado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE); 
            }
            
  
    }catch(SQLException ex){

          JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);

    }
}
    
}
