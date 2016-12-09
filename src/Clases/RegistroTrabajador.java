/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Clases;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.swing.JOptionPane;

/**
 *
 * @author Reymundo Tenorio
 */
public class RegistroTrabajador {
    
    
public static ResultSet resultado;

public static void Agregar_RegistroTrabajador(int ID_Trabajador, int ID_Usuario,
        String Comedor){

    
int Dia, Mes, Ano;

Calendar c = new GregorianCalendar();
   
Dia = c.get(Calendar.DATE);
Mes = c.get(Calendar.MONTH)+1;
Ano = c.get(Calendar.YEAR);
 
        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[RegistroT] (?,?,?,?,?,?,?)}");

                
                        consulta.setInt(1, ID_Trabajador);
                        consulta.setInt(2, ID_Usuario);
                        consulta.setString(3, Comedor);
                        consulta.setInt(4, Dia);
                        consulta.setInt(5, Mes);
                        consulta.setInt(6, Ano);
                        
                        
                        
                      
                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Registro Trabajador Guardado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }

 

    }

    
}
