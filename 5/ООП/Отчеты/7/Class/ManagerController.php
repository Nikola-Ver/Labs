<?php
namespace Class;


require_once ('MainController.php');



use Class;
/**
 * @author SAI-HOME
 * @version 1.0
 * @created 03-дек.-2020 23:36:09
 */
class ManagerController extends MainController
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