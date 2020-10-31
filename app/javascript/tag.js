if (location.pathname.match("items/new") || ("items/item.id/edit")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("item-tags");
    inputElement.addEventListener('keyup', () => {
      const keyword = inputElement.value;
      const XHR  = new XMLHttpRequest();
      XHR.open("GET", `search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const tagName = XHR.response.keyword;
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.tagname;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              inputElement.value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};