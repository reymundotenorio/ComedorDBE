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
public class ReiniciarContadores {
    
    
public static ResultSet resultado;

public static void ReiniciarContadores(){

 int Semana;
 int Ano;
    
Calendar calendar = Calendar.getInstance();
calendar.setFirstDayOfWeek(Calendar.MONDAY);
calendar.setMinimalDaysInFirstWeek(5);

Calendar c = new GregorianCalendar();

Ano = c.get(Calendar.YEAR);
Semana = calendar.get(Calendar.WEEK_OF_YEAR);

int UltimaSemana = 0;

try{
    resultado = Conexion.consulta("Select Max([Semana]) from [dbo].[Semanas] where [Anio] = "+Ano);
    
    while(resultado.next()){
        UltimaSemana = resultado.getInt(1);
    }

}catch(SQLException ex){
    
}

   
if(UltimaSemana<Semana){


        try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[ReiniciarContadores] (?,?)}");

                
                        consulta.setInt(1, Semana);
                        consulta.setInt(2, Ano);
                      
                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Se Han Inicializados Los Contadores Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }



}

    }


}
