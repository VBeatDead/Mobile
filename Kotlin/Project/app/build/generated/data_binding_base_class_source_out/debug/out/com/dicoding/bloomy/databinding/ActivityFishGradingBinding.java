// Generated by view binder compiler. Do not edit!
package com.dicoding.bloomy.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.cardview.widget.CardView;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.dicoding.bloomy.R;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.button.MaterialButton;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivityFishGradingBinding implements ViewBinding {
  @NonNull
  private final RelativeLayout rootView;

  @NonNull
  public final TextView TextView;

  @NonNull
  public final BottomNavigationView bottomNavigation;

  @NonNull
  public final MaterialButton buttongaleri;

  @NonNull
  public final MaterialButton buttongrading;

  @NonNull
  public final MaterialButton buttonkamera;

  @NonNull
  public final FrameLayout container;

  @NonNull
  public final RelativeLayout tes;

  @NonNull
  public final CardView uploadCard;

  @NonNull
  public final ImageView uploadIcon;

  @NonNull
  public final TextView uploadText;

  @NonNull
  public final ImageView uploadedImage;

  @NonNull
  public final RelativeLayout whiteBox;

  private ActivityFishGradingBinding(@NonNull RelativeLayout rootView, @NonNull TextView TextView,
      @NonNull BottomNavigationView bottomNavigation, @NonNull MaterialButton buttongaleri,
      @NonNull MaterialButton buttongrading, @NonNull MaterialButton buttonkamera,
      @NonNull FrameLayout container, @NonNull RelativeLayout tes, @NonNull CardView uploadCard,
      @NonNull ImageView uploadIcon, @NonNull TextView uploadText, @NonNull ImageView uploadedImage,
      @NonNull RelativeLayout whiteBox) {
    this.rootView = rootView;
    this.TextView = TextView;
    this.bottomNavigation = bottomNavigation;
    this.buttongaleri = buttongaleri;
    this.buttongrading = buttongrading;
    this.buttonkamera = buttonkamera;
    this.container = container;
    this.tes = tes;
    this.uploadCard = uploadCard;
    this.uploadIcon = uploadIcon;
    this.uploadText = uploadText;
    this.uploadedImage = uploadedImage;
    this.whiteBox = whiteBox;
  }

  @Override
  @NonNull
  public RelativeLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivityFishGradingBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivityFishGradingBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_fish_grading, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivityFishGradingBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.TextView;
      TextView TextView = ViewBindings.findChildViewById(rootView, id);
      if (TextView == null) {
        break missingId;
      }

      id = R.id.bottom_navigation;
      BottomNavigationView bottomNavigation = ViewBindings.findChildViewById(rootView, id);
      if (bottomNavigation == null) {
        break missingId;
      }

      id = R.id.buttongaleri;
      MaterialButton buttongaleri = ViewBindings.findChildViewById(rootView, id);
      if (buttongaleri == null) {
        break missingId;
      }

      id = R.id.buttongrading;
      MaterialButton buttongrading = ViewBindings.findChildViewById(rootView, id);
      if (buttongrading == null) {
        break missingId;
      }

      id = R.id.buttonkamera;
      MaterialButton buttonkamera = ViewBindings.findChildViewById(rootView, id);
      if (buttonkamera == null) {
        break missingId;
      }

      id = R.id.container;
      FrameLayout container = ViewBindings.findChildViewById(rootView, id);
      if (container == null) {
        break missingId;
      }

      id = R.id.tes;
      RelativeLayout tes = ViewBindings.findChildViewById(rootView, id);
      if (tes == null) {
        break missingId;
      }

      id = R.id.uploadCard;
      CardView uploadCard = ViewBindings.findChildViewById(rootView, id);
      if (uploadCard == null) {
        break missingId;
      }

      id = R.id.uploadIcon;
      ImageView uploadIcon = ViewBindings.findChildViewById(rootView, id);
      if (uploadIcon == null) {
        break missingId;
      }

      id = R.id.uploadText;
      TextView uploadText = ViewBindings.findChildViewById(rootView, id);
      if (uploadText == null) {
        break missingId;
      }

      id = R.id.uploadedImage;
      ImageView uploadedImage = ViewBindings.findChildViewById(rootView, id);
      if (uploadedImage == null) {
        break missingId;
      }

      id = R.id.white_box;
      RelativeLayout whiteBox = ViewBindings.findChildViewById(rootView, id);
      if (whiteBox == null) {
        break missingId;
      }

      return new ActivityFishGradingBinding((RelativeLayout) rootView, TextView, bottomNavigation,
          buttongaleri, buttongrading, buttonkamera, container, tes, uploadCard, uploadIcon,
          uploadText, uploadedImage, whiteBox);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
