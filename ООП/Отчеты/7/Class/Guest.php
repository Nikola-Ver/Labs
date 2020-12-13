<?php
namespace Class;


require_once ('User.php');
require_once ('GuestController.php');



use Class;
use Class;
/**
 * @author Nikola-Ver
 * @version 1.0
 * @created 03-���.-2020 23:36:09
 */
class Guest extends User, GuestController
{

	function __construct()
	{
	}

	function __destruct()
	{
	}



	public function RegIn()
	{
	}

	public function SignIn()
	{
	}

	/**
	 * 
	 * @param sortParamId
	 */
	public function SortProducts(int $sortParamId)
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