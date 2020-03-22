const _getCSRFToken = () =>
  document.querySelector("meta[name='csrf-token']").getAttribute("content");

const getHeaders = () => ({
  "X-CSRF-TOKEN": _getCSRFToken(),
  "Content-Type": "application/json",
  Accept: "application/json"
});

export default { getHeaders };
