package Principal;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.text.Position;

import org.hibernate.mapping.Column;

import funcionalidades.Funcionalidades;
import modelloteria.Sorteo;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Font;
import java.util.List;

import javax.swing.JPanel;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JTable;
import javax.swing.JList;
import javax.swing.ListSelectionModel;

public class Main {

	private JFrame frame;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Main window = new Main();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public Main() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 450, 300);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JLabel lblLoteria = new JLabel("Loteria");
		lblLoteria.setFont(new Font("Times New Roman", Font.BOLD | Font.ITALIC, 30));
		lblLoteria.setHorizontalAlignment(0);
		frame.getContentPane().add(lblLoteria, BorderLayout.NORTH);
		
		JPanel panel = new JPanel();
		frame.getContentPane().add(panel, BorderLayout.CENTER);
		
		JList list = new JList();
		list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		
		DefaultListModel listmodel = new DefaultListModel();
		
		//declaramos e instanciamos un objeto de funcionalidades
		Funcionalidades f = new Funcionalidades();
		//recogemos todos los sorteos
		//List<Sorteo> sorteos = f.getSorteos();
		
		//for(int i=0;i<sorteos.size();i++){
		//	listmodel.addElement(sorteos.get(i).toString());
	//	}
		
		list.setModel(listmodel);
		panel.add(list);
	}

}
