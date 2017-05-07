module HTMLElements

  export table

  function table(cur_matrix::Matrix; header_row=[], title=nothing)

    cur_table = ""

    if title != nothing
      cur_table *= "<h2 style='padding: 10px'>$title</h2>"
    end

    cur_table *= "<table class='table table-striped'>"

    if !isempty(header_row)
      cur_table *= "<thead><tr>"

      for cur_header in header_row
        cur_table *= "<th>$cur_header</th>"
      end

      cur_table *= "</tr></thead>"
    end

    cur_table *= "<tbody>"

    for ii in 1:size(cur_matrix, 1)

      cur_table *= "<tr>"

      for jj in 1:size(cur_matrix, 2)
        cur_table *= "<td>"

        cur_table *= string(cur_matrix[ii, jj])

        cur_table *= "</td>"
      end

      cur_table *= "</tr>"

    end

    cur_table *= "</tbody>"

    cur_table *= "</table>"

    return HTML(cur_table)

  end

end
