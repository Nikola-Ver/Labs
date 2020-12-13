<?php
namespace Class;


require_once ('User.php');
require_once ('DirectorController.php');



use Class;
use Class;
/**
 * @author Nikola-Ver
 * @version 1.0
 * @created 03-���.-2020 23:36:08
 */
class Director extends User, DirectorController
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