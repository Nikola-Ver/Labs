<?php
namespace Class;


require_once ('StorageProducts.php');



use Class;
/**
 * @author SAI-HOME
 * @version 1.0
 * @created 03-дек.-2020 23:36:09
 */
class Order
{

	private $amount;
	private $date;
	private $id;
	private $price;
	private $status;
	private $storageProductsId;
	private $transactionId;
	private $userId;
	public $m_StorageProducts;

	function __construct()
	{
	}

	function __destruct()
	{
	}



	public function GetAmount()
	{
	}

	public function GetDate()
	{
	}

	public function GetFoodList()
	{
	}

	public function GetId()
	{
	}

	public function GetStatust()
	{
	}

	public function GetStorageId()
	{
	}

	public function GetSum()
	{
	}

	public function GetTransactionId()
	{
	}

	public function GetUserId()
	{
	}

}
?>