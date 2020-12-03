<?php
namespace Class;


require_once ('MainController.php');



use Class;
/**
 * @author SAI-HOME
 * @version 1.0
 * @created 03-дек.-2020 23:36:09
 */
class DirectorController extends MainController
{

	function __construct()
	{
	}

	function __destruct()
	{
	}



	/**
	 * 
	 * @param date
	 */
	public function GetActivityReport(Date $date)
	{
	}

	/**
	 * 
	 * @param date
	 */
	public function GetDeliveryReport(Date $date)
	{
	}

	/**
	 * 
	 * @param date
	 */
	public function GetProfitReport(Date $date)
	{
	}

	/**
	 * 
	 * @param report
	 */
	public function PrintReport(Object $report)
	{
	}

	public function SignOut()
	{
	}

}
?>