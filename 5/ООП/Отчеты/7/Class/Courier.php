<?php
namespace Class;


require_once ('User.php');
require_once ('CourierController.php');



use Class;
use Class;
/**
 * @author SAI-HOME
 * @version 1.0
 * @created 03-дек.-2020 23:36:08
 */
class Courier extends User, CourierController
{

	function __construct()
	{
	}

	function __destruct()
	{
	}



	/**
	 * 
	 * @param orderId
	 */
	public function ChangeOrderStatus(int $orderId)
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