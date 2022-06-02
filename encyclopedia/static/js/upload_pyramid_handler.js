let gf_count = 1, ef_count = 1, rel_count = 1;

// Generating Function
function add_gf_input(addbtn) {
    let funcnames = ['U', 'G', 'V', 'F'],
        usednames = [],
        parent = addbtn.parentNode,
        parents = document.getElementsByClassName(parent.className);
    
    gf_count++;            
    for (let i = 0; i < gf_count-1; i++) 
        usednames.push(parents[i].querySelector('.f_name').value)
            
    let cloned = parent.cloneNode(true);
    let name_to_assign = funcnames.filter(n => !usednames.includes(n))[0];
    if (name_to_assign == undefined)
        name_to_assign = ''
    cloned.querySelector('.f_name').value = name_to_assign;
    cloned.querySelector('.f_name').id = `generatingFunction-${gf_count-1}-f_name`;
    cloned.querySelector('.f_name').name = `generatingFunction-${gf_count-1}-f_name`;
    cloned.querySelector('.f_vars').id = `generatingFunction-${gf_count-1}-f_vars`;
    cloned.querySelector('.f_vars').name = `generatingFunction-${gf_count-1}-f_vars`;
    cloned.querySelector('.f_expr').value = '';
    cloned.querySelector('.f_expr').id = `generatingFunction-${gf_count-1}-f_expr`;
    cloned.querySelector('.f_expr').name = `generatingFunction-${gf_count-1}-f_expr`;
    

    parent.parentNode.appendChild(cloned);

    addbtn.innerHTML = '-';    
    addbtn.setAttribute('onclick','remove_gf_input(this)') ;    
}

function remove_gf_input(remove_btn) {
    let parent = remove_btn.parentNode;
    let currentNodeId = parent.querySelector('.f_name').id.match(/\d+/).toString();
    currentNodeId = parseInt(currentNodeId);
    
    gf_count--;
    
    for (let i = currentNodeId + 2; i < gf_count + 2; i++) {
        temp_el = parent.parentNode.children[i];
        temp_counter = temp_el.querySelector('.f_name').id.match(/\d+/).toString();
        temp_counter = parseInt(temp_counter);
        temp_el.querySelector('.f_name').id = `generatingFunction-${temp_counter-1}-f_name`;
        temp_el.querySelector('.f_name').name = `generatingFunction-${temp_counter-1}-f_name`;
        temp_el.querySelector('.f_vars').id = `generatingFunction-${temp_counter-1}-f_vars`;
        temp_el.querySelector('.f_vars').name = `generatingFunction-${temp_counter-1}-f_vars`;
        temp_el.querySelector('.f_expr').id = `generatingFunction-${temp_counter-1}-f_expr`;
        temp_el.querySelector('.f_expr').name = `generatingFunction-${temp_counter-1}-f_expr`;
    }
    
    parent.remove();
}

// Explicit Formula
function add_ef_input(addbtn) {
    let parent = addbtn.parentNode;
    parent.parentNode.parentNode.querySelector('.brace-left').style.display = 'block'
    ef_count++;            

    let cloned = parent.cloneNode(true);
    cloned.querySelector('.f_expr').value = '';
    cloned.querySelector('.f_expr').id = `explicitFormula-${ef_count-1}-f_expr`;
    cloned.querySelector('.f_expr').name = `explicitFormula-${ef_count-1}-f_expr`;
    if (ef_count > 1) {
        cloned.querySelector('.f_condition').value = '';
        cloned.querySelector('.f_condition').id = `explicitFormula-${ef_count-1}-f_condition`;
        cloned.querySelector('.f_condition').name = `explicitFormula-${ef_count-1}-f_condition`;
    } 

    parent.parentNode.appendChild(cloned);
    addbtn.innerHTML = '-';    
    addbtn.setAttribute('onclick','remove_ef_input(this)') ;    
    
    for (let i = 0; i < ef_count; i++) 
        parent.parentNode.children[i].querySelector('.f_condition').style.display = 'block';
        
}

function remove_ef_input(remove_btn) {
    let parent = remove_btn.parentNode;
    let currentNodeId = parent.querySelector('.f_expr').id.match(/\d+/).toString();
    currentNodeId = parseInt(currentNodeId);

    if (ef_count < 2) {
        return;
    }
    
    ef_count--;
    
    for (let i = currentNodeId + 1; i < ef_count + 1; i++) {
        temp_el = parent.parentNode.children[i];
        // console.log(temp_el);
        temp_counter = temp_el.querySelector('.f_expr').id.match(/\d+/).toString();
        temp_counter = parseInt(temp_counter);
        temp_el.querySelector('.f_expr').id = `explicitFormula-${temp_counter-1}-f_expr`;
        temp_el.querySelector('.f_expr').name = `explicitFormula-${temp_counter-1}-f_expr`;
        temp_el.querySelector('.f_condition').id = `explicitFormula-${temp_counter-1}-f_condition`;
        temp_el.querySelector('.f_condition').name = `explicitFormula-${temp_counter-1}-f_condition`;
        
    }
    
    let content = parent.parentNode;

    
    parent.remove()
    
    if (ef_count < 2) {
        content.parentNode.querySelector('.brace-left').style.display = 'none';
        content.children[0].querySelector('.f_condition').style.display = 'none';
    }
}


// Relations
function add_rel_input(addbtn) {
    let parent = addbtn.parentNode;
    rel_count++;            

    let cloned = parent.querySelector('.form-group-gf').cloneNode(true);
    cloned.querySelector('.related_seq').value = 0;
    cloned.querySelector('.related_seq').id = `relations-${rel_count-1}-relatedto_pyramid`;
    cloned.querySelector('.related_seq').name = `relations-${rel_count-1}-relatedto_pyramid`;

    cloned.querySelector('.related_tag').value = 0;
    cloned.querySelector('.related_tag').id = `relations-${rel_count-1}-tag`;
    cloned.querySelector('.related_tag').name = `relations-${rel_count-1}-tag`;

    parent.querySelector('.rels-wrapper').appendChild(cloned);
}

function remove_rel_input(remove_btn) {
    let parent = remove_btn.parentNode;
    let currentNodeId = parent.querySelector('.related_seq').id.match(/\d+/).toString();
    currentNodeId = parseInt(currentNodeId);

    if (rel_count < 2) {
        return;
    }
    
    rel_count--;
    
    for (let i = currentNodeId + 1; i < rel_count + 1; i++) {
        temp_el = parent.parentNode.children[i];
        // console.log(temp_el);
        temp_counter = temp_el.querySelector('.related_seq').id.match(/\d+/).toString();
        temp_counter = parseInt(temp_counter);
        temp_el.querySelector('.related_seq').id = `relations-${temp_counter-1}-relatedto_pyramid`;
        temp_el.querySelector('.related_seq').name = `relations-${temp_counter-1}-relatedto_pyramid`;
        temp_el.querySelector('.related_tag').id = `relations-${temp_counter-1}-tag`;
        temp_el.querySelector('.related_tag').name = `relations-${temp_counter-1}-tag`;
        
    }
    
    let content = parent.parentNode;

    
    parent.remove()
}

