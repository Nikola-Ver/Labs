<?php
namespace Class;


require_once ('IPayment.php');



use Class;
/**
 * @author Nikola-Ver
 * @version 1.0
 * @created 03-���.-2020 23:36:09
 */
class PaySystem implements IPayment
{

	function __construct()
	{
	}

	function __destruct()
	{
	}



	public function CheckPayment()
	{
	}

	/**
	 * 
	 * @param id
	 */
	public function SendTransaction(int $id)
	{
	}

}
?>