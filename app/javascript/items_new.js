function PriceInput () {

  const PriceInput = document.getElementById('item-price')
  const PriceContent = document.getElementById('add-tax-price')
  const PriceProfit = document.getElementById('profit')

  PriceInput.addEventListener('keyup', function(){
    const data =  document.getElementById("item-price").value;
    PriceContent.innerHTML = Math.ceil(data * 0.1)
    PriceProfit.innerHTML = Math.ceil(data * 0.9)
  })
};
window.addEventListener('load', PriceInput)