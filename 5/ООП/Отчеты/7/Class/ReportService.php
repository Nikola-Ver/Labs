<?php
namespace Class;


require_once ('IReport.php');
require_once ('PrintController.php');



use Class;
use Class;
/**
 * @author SAI-HOME
 * @version 1.0
 * @created 03-дек.-2020 23:36:09
 */
class ReportService extends PrintController implements IReport
{

	function __construct()
	{
	}

	function __destruct()
	{
	}



	/**
	 * 
	 * @param type
	 */
	public function GetReport(int $type)
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

}
?>