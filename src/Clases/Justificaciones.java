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
public class Justificaciones {
    
    
public static ResultSet resultado;

public static void Justificar_Estudiante(int ID_ContadorE){

  
        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[JustificarContadorE] (?)}");

                
                        consulta.setInt(1, ID_ContadorE);
                        
                      
                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Ausencia Estudiante Justificada Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }      

    }

public static void Justificar_Trabajador(int ID_ContadorT){

  
        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[JustificarContadorT] (?)}");

                
                        consulta.setInt(1, ID_ContadorT);
                        
                      
                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Ausencia Trabajador Justificada Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }      

    }



    
}
