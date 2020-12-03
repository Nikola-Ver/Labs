<?php
namespace Class;


require_once ('User.php');
require_once ('ManagerController.php');



use Class;
use Class;
/**
 * @author SAI-HOME
 * @version 1.0
 * @created 03-дек.-2020 23:36:09
 */
class Manager extends User, ManagerController
{

	function __construct()
	{
	}

	function __destruct()
	{
	}



	/**
	 * 
	 * @param storageId
	 */
	public function AddToCatalog(int $storageId)
	{
	}

	/**
	 * 
	 * @param foodItem
	 */
	public function AddToStorage(Object $foodItem)
	{
	}

	/**
	 * 
	 * @param foodId
	 */
	public function EditCatalog(int $foodId)
	{
	}

	public function ShowOrders()
	{
	}

	public function SignOut()
	{
	}

}
?>