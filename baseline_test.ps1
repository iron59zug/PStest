# waiting 4 inspirations
# 
# 

# choose file format
$choose_ext
$ext_com
export-csv $dest_path.csv
export-clixml $dest_path.xml
out-file $dest_path.txt 
#options for width, append, char-set ...: help -verb out
convertTo-html #|out-file $dest_path.html?
# eg for sending to a web service
$export_ref

# services
get-service | $ext_com 
get-process | 

# import and compare, diff=compare-object
# -r/-d = -[re|dif]ferenceOject
diff -r ($import_ref) -d ($current_state) #options: -property status, name
# res: <= means data from -r, => means data from -d

# eg. kill what's not needed
get-process -name $some_app | stop-process #-confirm; -whatif;
