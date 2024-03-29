package com.example.myapplication.ProductDetail.View;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.PopupMenu;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.myapplication.BoughtProducts.View.MyBoughtProductsActivity;
import com.example.myapplication.ProductDetail.Data.BuyData;
import com.example.myapplication.ProductDetail.Data.ProductDetailData;
import com.example.myapplication.ProductDetail.Data.ReturnBuyData;
import com.example.myapplication.ProductDetail.Presenter.ProductDetailPresenter;
import com.example.myapplication.ProductDetail.ProductDetailContract;
import com.example.myapplication.R;
import com.example.myapplication.RateProduct.View.RateProduct;
import com.example.myapplication.ViewAll.Data.ViewAllData;
import com.example.myapplication.ViewAll.View.ViewAllActivity;
import com.example.myapplication.addProduct.view.AddProductActivity;
import com.example.myapplication.beans.Direccion;
import com.example.myapplication.beans.Producto;
import com.example.myapplication.beans.Usuario;
import com.example.myapplication.loggedScreen.view.LoggedScreenActivity;
import com.example.myapplication.top.view.TopViewActivity;
import com.example.myapplication.topRated.View.TopRatedActivity;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;

public class ProductDetailActivity extends AppCompatActivity implements ProductDetailContract.View {
    ProductDetailContract.Presenter presenter = new ProductDetailPresenter(this);
    ArrayList<String> lstDirecciones = new ArrayList<>();
    ArrayList<ProductDetailData> lstArrayDirecciones;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_product_detail);
        initComponents();
    }

    public void initComponents() {

        Bundle extras = getIntent().getExtras();
        presenter.LoadAddresses(extras.getInt("id"));
        ViewAllData viewAllData = new ViewAllData();
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU) {
            viewAllData = extras.getSerializable("detalle", ViewAllData.class);
        }
        TextView productPrice = findViewById(R.id.detailPrice);
        TextView productName = findViewById(R.id.detailName);
        TextView productColor = findViewById(R.id.detailColor);
        TextView productState = findViewById(R.id.detailState);
        TextView productDesc = findViewById(R.id.detailDescription);
        TextView productSeller = findViewById(R.id.detailSellerName);
        ImageView productImg = findViewById(R.id.productDetailImg);
        String imgUrl = viewAllData.getImagen();
        if (!imgUrl.equals("")) {
            Picasso.get().load(imgUrl).into(productImg);
        }
        productPrice.setText(String.valueOf(viewAllData.getPrecio() + " €"));
        productName.setText(String.valueOf(viewAllData.getNombre()));
        productColor.setText(String.valueOf("Color: " + viewAllData.getColor()));
        productState.setText("Estado: " + viewAllData.getEstado());
        productDesc.setText(viewAllData.getDescripcion());
        productSeller.setText(viewAllData.getUsuario().getNombre());
        Button buyButton = findViewById(R.id.detailBuy);
        ViewAllData finalViewAllData = viewAllData;
        buyButton.setOnClickListener(e -> {
            System.out.println("Has pulsado el boton de comprar");
            BuyData data = new BuyData();
            data.setVendedor(new Usuario(finalViewAllData.getUsuario().getId()));
            data.setComprador(new Usuario(extras.getInt("id")));
            data.setProducto(new Producto(finalViewAllData.getId()));
            Spinner direccionSpinner = findViewById(R.id.spinnerDireccion);
            String selectedAddress = direccionSpinner.getSelectedItem().toString();
            for (int i = 0; i < lstDirecciones.size(); i++) {
                if (lstDirecciones.get(i).equalsIgnoreCase(lstArrayDirecciones.get(i).getDireccion())) {
                    data.setDireccion(new Direccion(lstArrayDirecciones.get(i).getId()));
                    break;
                }
            }
            System.out.println(data.toString());
            presenter.BuyButton(data);
        });


    }

    @Override
    public void SuccessLoadAddresses(ArrayList<ProductDetailData> lstDirecciones) {
        lstArrayDirecciones = lstDirecciones;
        for (ProductDetailData data : lstDirecciones) {
            this.lstDirecciones.add(data.getDireccion());
        }
        Spinner direccionSpinner = findViewById(R.id.spinnerDireccion);
        ArrayAdapter<String> arrayAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, this.lstDirecciones);
        direccionSpinner.setAdapter(arrayAdapter);
    }

    @Override
    public void FailureLoadAddresses(String err) {
        Toast.makeText(this, "Error al cargar las direcciones", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void SuccessBuy(ReturnBuyData returnBuyData) {
        Toast.makeText(this, "Objeto comprado con exito", Toast.LENGTH_SHORT).show();
        Intent intent = new Intent(ProductDetailActivity.this, LoggedScreenActivity.class);
        intent.putExtra("id", getIntent().getExtras().getInt("id"));
        startActivity(intent);
    }

    @Override
    public void FailureBuy(String err) {
        Toast.makeText(this, "Error al intentar comprar la prenda", Toast.LENGTH_SHORT).show();
    }
    private void showMenu(View view) {
        PopupMenu popupMenu = new PopupMenu(ProductDetailActivity.this, view);
        popupMenu.getMenuInflater().inflate(R.menu.pop_up_menu, popupMenu.getMenu());
        popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
            @Override
            public boolean onMenuItemClick(MenuItem item) {
                if (item.getItemId() == R.id.products) {
                    PopupMenu subPopupMenu = new PopupMenu(ProductDetailActivity.this, view);
                    subPopupMenu.getMenuInflater().inflate(R.menu.products_menu, subPopupMenu.getMenu());
                    subPopupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                        @Override
                        public boolean onMenuItemClick(MenuItem item) {
                            if (item.getItemId() == R.id.addProduct) {
                                Intent intent = new Intent(ProductDetailActivity.this, AddProductActivity.class);
                                Bundle extras = getIntent().getExtras();
                                intent.putExtra("id", extras.getInt("id"));
                                startActivity(intent);
                            } else {
                                Intent intent = new Intent(ProductDetailActivity.this, ViewAllActivity.class);
                                Bundle extras = getIntent().getExtras();
                                intent.putExtra("id", extras.getInt("id"));
                                startActivity(intent);
                            }
                            return false;
                        }
                    });
                    subPopupMenu.show();
                } else {
                    PopupMenu subPopupMenu = new PopupMenu(ProductDetailActivity.this, view);
                    subPopupMenu.getMenuInflater().inflate(R.menu.users_menu, subPopupMenu.getMenu());
                    subPopupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                        @Override
                        public boolean onMenuItemClick(MenuItem item) {
                            System.out.println("Esta es la ID que ha clickado: " +item.getItemId());
                            if (item.getItemId() == R.id.top10Sales) {
                                Intent intent = new Intent(ProductDetailActivity.this, TopViewActivity.class);
                                startActivity(intent);
                            } else if (item.getItemId() == R.id.myBoughtProducts) {
                                Intent intent = new Intent(ProductDetailActivity.this, MyBoughtProductsActivity.class);
                                Bundle extras = getIntent().getExtras();
                                intent.putExtra("id", extras.getInt("id"));
                                startActivity(intent);
                            } else {
                                Intent intent = new Intent(ProductDetailActivity.this, TopRatedActivity.class);
                                startActivity(intent);
                            }

                            return false;
                        }
                    });
                    subPopupMenu.show();
                }
                return false;
            }
        });
        popupMenu.show();
    }
}