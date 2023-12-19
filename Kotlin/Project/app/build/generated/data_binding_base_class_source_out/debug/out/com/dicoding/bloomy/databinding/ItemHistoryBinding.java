// Generated by view binder compiler. Do not edit!
package com.dicoding.bloomy.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.dicoding.bloomy.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ItemHistoryBinding implements ViewBinding {
  @NonNull
  private final LinearLayout rootView;

  @NonNull
  public final TextView countText;

  @NonNull
  public final ImageView countbackground;

  @NonNull
  public final RelativeLayout countlayout;

  @NonNull
  public final ImageView gradeBackground;

  @NonNull
  public final RelativeLayout gradeLayout;

  @NonNull
  public final TextView gradeText;

  @NonNull
  public final TextView harga;

  @NonNull
  public final ImageView image;

  @NonNull
  public final RelativeLayout layoutStatus;

  @NonNull
  public final ImageView packBackground;

  @NonNull
  public final RelativeLayout packLayout;

  @NonNull
  public final TextView packText;

  @NonNull
  public final TextView productPrice;

  @NonNull
  public final ImageView roundedImage;

  @NonNull
  public final TextView shop;

  @NonNull
  public final ImageView status;

  @NonNull
  public final TextView statusText;

  @NonNull
  public final TextView textBesideImage;

  private ItemHistoryBinding(@NonNull LinearLayout rootView, @NonNull TextView countText,
      @NonNull ImageView countbackground, @NonNull RelativeLayout countlayout,
      @NonNull ImageView gradeBackground, @NonNull RelativeLayout gradeLayout,
      @NonNull TextView gradeText, @NonNull TextView harga, @NonNull ImageView image,
      @NonNull RelativeLayout layoutStatus, @NonNull ImageView packBackground,
      @NonNull RelativeLayout packLayout, @NonNull TextView packText,
      @NonNull TextView productPrice, @NonNull ImageView roundedImage, @NonNull TextView shop,
      @NonNull ImageView status, @NonNull TextView statusText, @NonNull TextView textBesideImage) {
    this.rootView = rootView;
    this.countText = countText;
    this.countbackground = countbackground;
    this.countlayout = countlayout;
    this.gradeBackground = gradeBackground;
    this.gradeLayout = gradeLayout;
    this.gradeText = gradeText;
    this.harga = harga;
    this.image = image;
    this.layoutStatus = layoutStatus;
    this.packBackground = packBackground;
    this.packLayout = packLayout;
    this.packText = packText;
    this.productPrice = productPrice;
    this.roundedImage = roundedImage;
    this.shop = shop;
    this.status = status;
    this.statusText = statusText;
    this.textBesideImage = textBesideImage;
  }

  @Override
  @NonNull
  public LinearLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ItemHistoryBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ItemHistoryBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.item_history, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ItemHistoryBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.countText;
      TextView countText = ViewBindings.findChildViewById(rootView, id);
      if (countText == null) {
        break missingId;
      }

      id = R.id.countbackground;
      ImageView countbackground = ViewBindings.findChildViewById(rootView, id);
      if (countbackground == null) {
        break missingId;
      }

      id = R.id.countlayout;
      RelativeLayout countlayout = ViewBindings.findChildViewById(rootView, id);
      if (countlayout == null) {
        break missingId;
      }

      id = R.id.gradeBackground;
      ImageView gradeBackground = ViewBindings.findChildViewById(rootView, id);
      if (gradeBackground == null) {
        break missingId;
      }

      id = R.id.gradeLayout;
      RelativeLayout gradeLayout = ViewBindings.findChildViewById(rootView, id);
      if (gradeLayout == null) {
        break missingId;
      }

      id = R.id.gradeText;
      TextView gradeText = ViewBindings.findChildViewById(rootView, id);
      if (gradeText == null) {
        break missingId;
      }

      id = R.id.harga;
      TextView harga = ViewBindings.findChildViewById(rootView, id);
      if (harga == null) {
        break missingId;
      }

      id = R.id.image;
      ImageView image = ViewBindings.findChildViewById(rootView, id);
      if (image == null) {
        break missingId;
      }

      id = R.id.layoutStatus;
      RelativeLayout layoutStatus = ViewBindings.findChildViewById(rootView, id);
      if (layoutStatus == null) {
        break missingId;
      }

      id = R.id.packBackground;
      ImageView packBackground = ViewBindings.findChildViewById(rootView, id);
      if (packBackground == null) {
        break missingId;
      }

      id = R.id.packLayout;
      RelativeLayout packLayout = ViewBindings.findChildViewById(rootView, id);
      if (packLayout == null) {
        break missingId;
      }

      id = R.id.packText;
      TextView packText = ViewBindings.findChildViewById(rootView, id);
      if (packText == null) {
        break missingId;
      }

      id = R.id.productPrice;
      TextView productPrice = ViewBindings.findChildViewById(rootView, id);
      if (productPrice == null) {
        break missingId;
      }

      id = R.id.roundedImage;
      ImageView roundedImage = ViewBindings.findChildViewById(rootView, id);
      if (roundedImage == null) {
        break missingId;
      }

      id = R.id.shop;
      TextView shop = ViewBindings.findChildViewById(rootView, id);
      if (shop == null) {
        break missingId;
      }

      id = R.id.status;
      ImageView status = ViewBindings.findChildViewById(rootView, id);
      if (status == null) {
        break missingId;
      }

      id = R.id.statusText;
      TextView statusText = ViewBindings.findChildViewById(rootView, id);
      if (statusText == null) {
        break missingId;
      }

      id = R.id.textBesideImage;
      TextView textBesideImage = ViewBindings.findChildViewById(rootView, id);
      if (textBesideImage == null) {
        break missingId;
      }

      return new ItemHistoryBinding((LinearLayout) rootView, countText, countbackground,
          countlayout, gradeBackground, gradeLayout, gradeText, harga, image, layoutStatus,
          packBackground, packLayout, packText, productPrice, roundedImage, shop, status,
          statusText, textBesideImage);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
