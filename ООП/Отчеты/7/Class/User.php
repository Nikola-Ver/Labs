<?php
namespace Class;


require_once ('UserController.php');
require_once ('Order.php');



use Class;
use Class;
/**
 * @author Nikola-Ver
 * @version 1.0
 * @created 03-���.-2020 23:36:09
 */
class User extends UserController
{

	private $id;
	private $login;
	private $name;
	private $password;
	private $roleId;
	private $surname;
	public $m_Order;

	function __construct()
	{
	}

	function __destruct()
	{
	}



	/**
	 * 
	 * @param foodId
	 */
	public function AddToBin(int $foodId)
	{
	}

	public function MakeOrder()
	{
	}

	public function SignOut()
	{
	}

	/**
	 * 
	 * @param sortParamId
	 */
	public function SortProducts(int $sortParamId)
	{
	}

	public function ViewBin()
	{
	}

	/**
	 * 
	 * @param foodId
	 */
	public function ViewFullInfo(int $foodId)
	{
	}

	/**
	 * 
	 * @param categoryName
	 */
	public function ViewModel(String $categoryName)
	{
	}

}
?>