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
public class ContadorEstudiante {
    
    
public static ResultSet resultado;

public static void Agregar_ContadorEstudiante( ){

int ID_BecaAlimenticia;
    
int Dia, Mes, Ano;

Calendar c = new GregorianCalendar();
   
Dia = c.get(Calendar.DATE);
Mes = c.get(Calendar.MONTH)+1;
Ano = c.get(Calendar.YEAR);

    try{
        
    resultado = Conexion.consulta("Select [ID_BecaAlimenticia] from [dbo].[BecaAlimenticia] where [Estado_Beca] = 'Activo'");
    
    while(resultado.next()){
      
        ID_BecaAlimenticia = resultado.getInt(1);
        
          try {

        CallableStatement consulta = Conexion.con.prepareCall("{call [dbo].[ContadorEstudiante] (?,?,?,?)}");

                
                        consulta.setInt(1, ID_BecaAlimenticia);
                        consulta.setInt(2, Dia);
                        consulta.setInt(3, Mes);
                        consulta.setInt(4, Ano);
                        
                        
                      
                        consulta.execute();

         JOptionPane.showMessageDialog(null,"Contador de Estudiante Guardado Correctamente","Información",JOptionPane.INFORMATION_MESSAGE);

     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }
        
        
    }
    
     }   catch (SQLException ex) {     
      JOptionPane.showMessageDialog(null,ex.getMessage(),"Error",JOptionPane.ERROR_MESSAGE);
  }
   
      



        

    }


}