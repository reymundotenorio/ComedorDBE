/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.edisoncor.gui.comboBox;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GradientPaint;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Paint;
import java.awt.RenderingHints;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.geom.Rectangle2D;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.ButtonModel;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.SwingConstants;
import javax.swing.border.EmptyBorder;
import javax.swing.plaf.basic.BasicComboBoxUI;

/**
 *
 * @author Edison
 */
public class ComboBoxRectIcon extends JComboBox{


    protected float anchoDeBorde=1f;
    protected Color colorDeBorde = new Color(173,173,173);
    private Icon icono;

    public ComboBoxRectIcon() {
        setOpaque(false);
        setBorder(new EmptyBorder(0,5,0,2));
        setPreferredSize(new Dimension(69, 20));
        setFont(new Font("Arial", Font.BOLD, 13));
        setUI(new BasicComboBoxUI(){

            @Override
            protected JButton createArrowButton() {
                ButtonArrow arrow = new ButtonArrow();
                arrow.setBorder(new EmptyBorder(0, 0, 0, 0));
                arrow.setHorizontalAlignment(SwingConstants.LEFT);
                return arrow;
            }
            
        });
    }


    @Override
    protected void paintComponent(Graphics g) {

        Graphics2D g2 = (Graphics2D) g;
        Paint oldPaint = g2.getPaint();

        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                RenderingHints.VALUE_ANTIALIAS_ON);
        Rectangle2D.Float r2d = new Rectangle2D.Float(
                0,0,getWidth(),getHeight());
        g2.clip(r2d);

        g2.setColor(getBackground());
        g2.fillRect(0,0,getWidth(),getHeight());

        g2.setColor(getForeground());
        
        g2.setPaint(oldPaint);
        super.paintComponent(g);
    }

    

    @Override
    protected void paintBorder(Graphics g) {
        int x = 1, y = 0;
        int w = getWidth() - 4, h = getHeight() - 1;
        Graphics2D g2 = (Graphics2D) g.create();
        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                RenderingHints.VALUE_ANTIALIAS_ON);
        g2.setStroke(new BasicStroke(anchoDeBorde));
        g2.setColor(colorDeBorde);
        g2.drawRect(x, y, w, h);
        g2.dispose();
    }

    public Icon getIcono() {
        return icono;
    }

    public void setIcono(Icon icono) {
        this.icono = icono;
    }

    public float getAnchoDeBorde() {
        return anchoDeBorde;
    }

    public void setAnchoDeBorde(float anchoDeBorde) {
        this.anchoDeBorde = anchoDeBorde;
    }

    public Color getColorDeBorde() {
        return colorDeBorde;
    }

    public void setColorDeBorde(Color colorDeBorde) {
        this.colorDeBorde = colorDeBorde;
    }


    private class ButtonArrow extends JButton{

    private Image buttonHighlight;
    private Image arrow;
    private boolean foco=false;


    public ButtonArrow(Icon icon) {
        super(icon);
    }

    public ButtonArrow() {
        setOpaque(false);
        setContentAreaFilled(false);
        setFocusPainted(false);
        setBorderPainted(false);
        setText("");
        setFont(new Font("Arial", Font.BOLD, 14));
        setForeground(new Color(255,255,255));
        buttonHighlight = loadImage("/resources/header-halo.png");
        arrow = loadImage("/resources/abajo.png");
         addFocusListener(new FocusListener() {

            public void focusGained(FocusEvent e) {
                foco=true;
            }

            public void focusLost(FocusEvent e) {
                foco=false;
            }
        });
    }

    private  Image loadImage(String fileName) {
        try {
            return ImageIO.read(ButtonArrow.class.getResource(fileName));
        } catch (IOException ex) {
            return null;
        }
    }



    @Override
    protected void paintComponent(Graphics g) {
        Graphics2D g2 = (Graphics2D) g;
        Paint oldPaint = g2.getPaint();

        Rectangle2D.Float r2d = new Rectangle2D.Float(
                0,0,getWidth(),getHeight());
        g2.clip(r2d);

        ButtonModel modelo = getModel();

        if(getIcono()==null)
            g2.drawImage(arrow,
                    0,0,
                    getWidth(), getHeight(), null);
        else{
            g2.drawImage(((ImageIcon)getIcono()).getImage(),
                    0,0,
                    getWidth(), getHeight(), null);
        }

        if(modelo.isRollover() | foco){
            g2.drawRect(0, 0, getWidth(), getHeight());
            g2.drawImage(buttonHighlight,
                    0,0,
                    getWidth(), getHeight(), null);
        }


        g2.setPaint(oldPaint);


    }


    }
}
