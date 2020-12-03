<?php
namespace Class;


require_once ('IPayment.php');



use Class;
/**
 * @author SAI-HOME
 * @version 1.0
 * @created 03-дек.-2020 23:36:09
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