package com.xxharutoxx.vistas;

import com.xxharutoxx.modulos.Producto;


import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentAdapter;

public class VPrincipal extends JFrame {
    private JPanel panel1;
    private JButton btnProveedor;
    private JButton btnProducto;
    private JPanel pnPrincipal;


    public VPrincipal(){
        setContentPane(panel1);
        setSize(1024, 600);
        setDefaultCloseOperation(3);
        btnProducto.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            cargarFormProducto();
            }
        });
        pnPrincipal.addComponentListener(new ComponentAdapter() {
        });
        btnProveedor.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                cargarFormProveedor();

            }
        });
    }
    private void cargarFormProducto(){
        VProducto pro=new VProducto();
        pnPrincipal.add(pro.getPanel());
        setVisible(true);
    }
    private void cargarFormProveedor(){
        VProveedor prov=new VProveedor();
        pnPrincipal.add(prov.getPanelP());
        setVisible(true);
    }
}
