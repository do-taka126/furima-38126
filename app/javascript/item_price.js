window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const addTaxDom = document.getElementById("add-tax-price");
    const inputValue = priceInput.value;
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    
    const profitNumber = document.getElementById("profit")
    const value_result = Math.floor(inputValue * 0.1)
    profitNumber.innerHTML = Math.floor(inputValue - value_result);
  })
});