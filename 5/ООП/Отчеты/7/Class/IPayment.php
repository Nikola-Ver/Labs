<?php
namespace Class;




/**
 * @author Nikola-Ver
 * @version 1.0
 * @created 03-���.-2020 23:36:09
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