import 'package:flutter/material.dart';
import 'package:myshop/providers/product.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatefulWidget {
  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _priceNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _forms = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', price: 0, imageUrl: '', description: '');
  var isInit = true;
  var isLoading = false;
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': ''
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    print('initstate am running');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      print('i am in did change dependency');
      final productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': _editedProduct.imageUrl
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print('dispose is running');
    _priceNode.dispose();
    _imageFocusNode.removeListener(_updateImageUrl);
    _descriptionNode.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() async {
    var isValid = _forms.currentState.validate();

    if (!isValid) {
      return;
    }
    _forms.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProducts(_editedProduct.id, _editedProduct);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProducts(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('An error occured'),
                content: Text('Something went wrong'),
                // ignore: deprecated_member_use
                actions: [
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              );
            });
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _forms,
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    TextFormField(
                      initialValue: _editedProduct.title,
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Tilte';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: value,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            price: _editedProduct.price);
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceNode);
                      },
                    ),
                    TextFormField(
                      initialValue: _editedProduct.price.toString(),
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a Price';
                        }
                        if (double.tryParse(value) == null) {
                          //we use tryparse because for invalid value it does not give error it gives null
                          return 'Enter a valid Price';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Price cant be ${double.parse(value)}';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            price: double.parse(value));
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionNode);
                      },
                    ),
                    TextFormField(
                      initialValue: _editedProduct.description,
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Description Of The Product';
                        }
                        if (value.length < 15) {
                          return 'Length of description should be more than 15';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            description: value,
                            imageUrl: _editedProduct.imageUrl,
                            price: _editedProduct.price);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 10, right: 16),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: (_imageUrlController.text.isEmpty)
                              ? Text(
                                  'Enter Url',
                                  textAlign: TextAlign.center,
                                )
                              : FittedBox(
                                  child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                )),
                        ),
                        Expanded(
                            child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          focusNode: _imageFocusNode,
                          controller: _imageUrlController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter A URL';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Enter a valid URL';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                                title: _editedProduct.title,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                                description: _editedProduct.description,
                                imageUrl: value,
                                price: _editedProduct.price);
                          },
                          onEditingComplete: () {
                            setState(() {});
                          },
                        )),
                      ],
                    ),

                    // ignore: deprecated_member_use
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 7),
                          child: RaisedButton(
                              child: Text('Submit Form',
                                  style: TextStyle(color: Colors.black)),
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {
                                _saveForm();
                              }),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}
