""" Crawler algorithm
while !unvisited_list.empty():
    get URL
    fetch content
    record content by rule set into persistent storage
    remove url from unvisited_list
    add url into visited_list
    get url_list from content
    for url in url_list:
        if url matches rule set:
            if !unvisited_list.has(url) and !visited_list.has(url):
                add url into unvisited_list
"""

