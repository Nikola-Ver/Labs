<?php
namespace Class;




/**
 * @author SAI-HOME
 * @version 1.0
 * @created 03-дек.-2020 23:36:09
 */
interface IPayment
{

	public function CheckPayment();

	/**
	 * 
	 * @param id
	 */
	public function SendTransaction(int $id);

}
?>