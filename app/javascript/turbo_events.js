addEventListener("turbo:frame-missing", (event) => {
    const template = document.getElementById("turbo_error_template");

    event.preventDefault();

    event.target.replaceChildren(template.content.cloneNode(true));
})
