function init_variables(_exactResults, _relatedResults) {
  _exactResults.forEach((res) => (res.exact = true));
  __results = _exactResults.concat(_relatedResults);
  pages_in_total = Math.ceil(__results.length / RESULTS_PER_PAGE);
  stored_page = localStorage.getItem("current_page");
  if (stored_page) current_page = stored_page;
  set_bounds();
}

function set_bounds() {
  (left_b = current_page - 3), (right_b = current_page + 3);
  if (left_b < 1) left_b = 1;
  if (right_b > pages_in_total) right_b = pages_in_total;
}

function display_results() {
  document.querySelector(".results").innerHTML = ``;

  let temp = current_page * RESULTS_PER_PAGE + 1;
  let until = temp > __results.length ? __results.length : temp;
  for (let i = (current_page - 1) * RESULTS_PER_PAGE; i < until; i++) {
    if (__results[i]["sequence_number"]) {
      // html_to_append = `<div class="result_brief ${__results[i].exact ? "exact" : ""}">` ? __results[i]['statuscode'] == 0 : ;

      if (__results[i]["statuscode"] == 0)
        html_to_append = `<div class="result_brief ${
          __results[i].exact ? "exact-result" : ""
        }">
                    <div class="result_title textlinks">
                        <a href="pyramid/${
                          __results[i]["sequence_number"]
                        }">Pyramid ${__results[i]["sequence_number"]}</a>   
                    </div>`;
      else if (__results[i]["statuscode"] == 1)
        html_to_append = `<div class="result_brief ${
          __results[i].exact ? "exact-result" : ""
        } danger">
                    <div class="result_title textlinks">
                        <a href="pyramid/${
                          __results[i]["sequence_number"]
                        }">Pyramid ${__results[i]["sequence_number"]}</a>   
                        <div class="textlinks align-flex-end" data-tooltip="This pyramid is not valid. It'll be fixed as soon as posible.">
                            <a class="material-symbols-outlined broken_info">help</a>
                        </div>
                    </div>`;

      html_to_append += `
                

                <div class="data">
                    <span class="unit-description"><i>Preview</i></span>
                    <a href="pyramid/${__results[i]["sequence_number"]}" id="${
        __results[i]["sequence_number"]
      }">
                        ${katex.renderToString(
                          __results[i]["generating_function"].slice(3, -3),
                          {
                            delimiters: [
                              { left: "$$", right: "$$", display: true },
                              { left: "$", right: "$", display: false },
                              { left: "\\[", right: "\\]", display: true },
                            ],
                          }
                        )}
                    </a>   
                </div>   
            `;
      if (__results[i]["author"])
        html_to_append += `
                    <div class="author">
                        <span class="unit-description"><i>Author</i></span>
                        <div class="author-credits textlinks">
                        
                            <a href="account/${
                              __results[i]["author"]["username"]
                            }" class="authorlink">
                                <img
                                src="/static/profile_pictures/${
                                  __results[i]["author"]["profile_image"]
                                }"
                                alt=${__results[i]["author"][
                                  "username"
                                ].replace(/^\w/, (c) => c.toUpperCase())}
                                title=${__results[i]["author"][
                                  "username"
                                ].replace(/^\w/, (c) => c.toUpperCase())}
                                width="40" height="40"
                                class="profile_img">
                            </a>
                            <a href="account/${
                              __results[i]["author"]["username"]
                            }">
                                ${__results[i]["author"]["username"].replace(
                                  /^\w/,
                                  (c) => c.toUpperCase()
                                )}
                            </a>
                        </div>
                    </div>
                </div>
                `;
    } else
      html_to_append = `
            <div class="result_brief ${
              __results[i].exact ? "exact-result" : ""
            } user_brief">
                <a href="account/${
                  __results[i]["username"]
                }" class="authorlink">
                    <img
                        src="/static/profile_pictures/${
                          __results[i]["profile_image"]
                        }"
                        alt=${__results[i]["username"].replace(/^\w/, (c) =>
                          c.toUpperCase()
                        )}
                        title=${__results[i]["username"].replace(/^\w/, (c) =>
                          c.toUpperCase()
                        )}
                        width="130" height="130"
                        class="profile_img"
                        style="border-radius: 5%;">
                </a>
                <div class="result_title textlinks">
                    <a href="account/${__results[i]["username"]}">
                        ${__results[i]["username"].replace(/^\w/, (c) =>
                          c.toUpperCase()
                        )}
                    </a>   
                </div>

            </div>
            `;
    document.querySelector(".results").innerHTML += html_to_append;
  }
}

function update_page(page_id) {
  current_page = page_id;
  set_bounds();
  display_results();
  display_nav();
}

function display_nav() {
  if (pages_in_total > 1) {
    navhtml = ``;
    navhtml += `
        <div class="page_nav textlinks">
            <span>Page:</span>`;
    if (current_page - 4 > 1)
      navhtml += `
                <a href="#results" class="page_nav-element" onclick="update_page(1)">1</a>
                <span>...</span>`;
    else if (current_page - 4 == 1)
      navhtml += `<a href="#results" class="page_nav-element" onclick="update_page(1)">1</a>`;
    for (let page_id = left_b; page_id < right_b + 1; page_id++)
      if (page_id == current_page)
        navhtml += `<div class="page_nav-element">${page_id}</div>`;
      else
        navhtml += `<a href="#results" class="page_nav-element" onclick="update_page(${page_id})">${page_id}</a>`;

    if (current_page + 4 < pages_in_total)
      navhtml += `
            <span>...</span>
            <a href="#results" class="page_nav-element" onclick="update_page(${pages_in_total})">${pages_in_total}</a>`;
    else if (current_page + 4 == pages_in_total)
      navhtml += `<a href="#results" class="page_nav-element" onclick="update_page(${pages_in_total})">${pages_in_total}</a>`;

    optionshtml = ``;

    for (let page_id = 1; page_id < pages_in_total + 1; page_id++) {
      optionshtml += `
            <option value="${page_id}"`;
      if (page_id == current_page) optionshtml += `selected`;
      optionshtml += `>${page_id}</option>`;
    }

    navhtml += `
        </div>
        <span>or</span>
        <div class="manual_page_input">
            <select class="page_nav-element pagenum" onchange="update_page(parseInt(this.options[this.selectedIndex].text))">
                ${optionshtml}
            </select>
        </div>`;

    document.querySelector(".nav_wrapper").innerHTML = navhtml;
  }
}

let pages_in_total,
  RESULTS_PER_PAGE = 20,
  current_page = 1,
  __results;
