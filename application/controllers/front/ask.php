<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *freshman-qa
 *
 *@author   Maureen
 */

/*
 *问题控制器
 */


class Ask extends CI_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->library('twig');
        $this->load->model('front/ask_model','model');
    }
    

    public function create() {
        $data = array();
        $this->load->helper('form');
        $this->load->helper('url');
        $this->load->library('form_validation');
        $this->form_validation->set_rules(array(
            array(
                'field' => 'question',
                'label' => 'question',
                'rules' => 'required|xss_clean'
            )
        ));

        echo form_open('front/ask/create');

        if ($this->form_validation->run() == false) {
            $this->twig->display('front/ask.html');
        } else {
            $data['question'] = $this->input->post('question');
            $data['description'] = $this->input->post('description');
            $this->model->create(array(
                'question' => $data['question'],
                'description' => $data['description']
            ));
        };
        
        
    } 
}
