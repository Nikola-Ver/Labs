<?php
namespace Class;




/**
 * @author Nikola-Ver
 * @version 1.0
 * @created 03-���.-2020 23:36:09
 */
interface IReport
{

	/**
	 * 
	 * @param date
	 */
	public function GetActivityReport(Date $date);

	/**
	 * 
	 * @param date
	 */
	public function GetDeliveryReport(Date $date);

	/**
	 * 
	 * @param date
	 */
	public function GetProfitReport(Date $date);

}
?>