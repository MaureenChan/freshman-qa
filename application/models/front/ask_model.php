<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/*
 *freshman-qa
 *
 *@author Maureen
 */

/*
 *问题模型
 */
 
class Ask_model extends CI_Model{

    /*
     *增加一个问题条目
     *
     *@param array
     */
    public function create($value) {
        $this->db->insert('questions', $value);
        return $this->db->insert_id();
    }
}
