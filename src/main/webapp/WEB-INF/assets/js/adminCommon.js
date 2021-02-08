// Check blank
function formInput(tag, msg) {
    if (tag.value.trim() !== '') return false;
    alert(msg);
    tag.focus();
    return true;
}
