package tap.company.benefit_pay_flutter;

import android.content.Context;
import android.view.View;

import androidx.annotation.Nullable;

import android.view.LayoutInflater;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;


import company.tap.tapbenefitpay.open.web_wrapper.TapBenefitPay;
import io.flutter.plugin.platform.PlatformView;

import java.util.Map;

public class TapBenefitViewManager implements PlatformView {


    private TapBenefitPay tapCardKit;
    private View view;


    TapBenefitViewManager(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
        view = LayoutInflater.from(context).inflate(R.layout.tap_benefit_pay_view, null);
        tapCardKit = view.findViewById(R.id.benfit_pay);
    }

    @Nullable
    @Override
    public View getView() {
        return view;
    }

    @Override
    public void dispose() {

    }
}
