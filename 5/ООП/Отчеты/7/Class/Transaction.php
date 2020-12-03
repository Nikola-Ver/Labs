<?php
namespace Class;


require_once ('IPayment.php');
require_once ('Order.php');



use Class;
use Class;
/**
 * @author Nikola-Ver
 * @version 1.0
 * @created 03-���.-2020 23:36:09
 */
class Transaction implements IPayment
{

	private $bankAccId;
	private $date;
	private $id;
	private $sum;
	public $m_Order;

	function __construct()
	{
	}

	function __destruct()
	{
	}



	public function CheckPayment()
	{
	}

	public function GetDate()
	{
	}

	/**
	 * 
	 * @param id
	 */
	public function SendTransaction(int $id)
	{
	}

	/**
	 * 
	 * @param date
	 */
	public function SetDate(Date $date)
	{
	}

}
?>