import { Controller } from "stimulus";
import html2canvas from "html2canvas";

export default class extends Controller {
  static targets = ["form", "preview", "when", "lostItemCategory", "userHeight", "userWeight", "lostItemDescription"]

  takeScreenshot(event) {
    event.preventDefault();

    const previewHtml = this.generatePreviewHtml();

    const previewElement = document.createElement('div');
    previewElement.innerHTML = previewHtml;

    html2canvas(previewElement).then(canvas => {
      let imgURL = canvas.toDataURL('image/png');
      this.previewTarget.src = imgURL;

      console.log('imgURL:', imgURL);

      this.submitForm(imgURL);
    });
  }

  submitForm(imgURL) {
    const formData = new FormData(this.formTarget);
    formData.set('image_data_url', imgURL);  // use `set` instead of `append`
  
    fetch(this.formTarget.action, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        // remove 'Content-Type' header
      },
      body: formData
    })
      .then(response => response.json())
      .then(data => {
        // do something
      })
      .catch(error => {
        console.error('Error:', error);
      });
  }

  generatePreviewHtml() {
    const when = this.whenTarget.value;
    const lostItemCategory = this.lostItemCategoryTarget.value;
    const userHeight = this.userHeightTarget.value;
    const userWeight = this.userWeightTarget.value;
    const lostItemDescription = this.lostItemDescriptionTarget.value;

    // ユーザーが入力した情報をもとにHTMLを生成
    return `
      <div>
        <h2>${when}</h2>
        <h2>${lostItemCategory}</h2>
        <h2>${userHeight}</h2>
        <h2>${userWeight}</h2>
        <p>${lostItemDescription}</p>
      </div>
    `;
  }
}