echo "Jumpo installer"
echo "key one" $1
echo "$2"
PUBLIC_KEY="\"""`cat $2`""\""
echo "key two" $PUBLIC_KEY

sed -r -i "s%paste%${PUBLIC_KEY}%g" "$1"
echo "Jumpo configmap done"