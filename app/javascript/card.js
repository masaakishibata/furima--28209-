const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const from = document.getElementById('charge-form');
  from.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById('charge-form');
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("orders[number]"),
      cvc: formData.get("orders[cvc]"),
      exp_month: formData.get("orders[exp_month]"),
      exp_year: `20${formData.get("orders[exp_year]")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById('charge-form');
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      };

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById('charge-form').submit();
    });
  });
};

window.addEventListener("load", pay);