import 'package:doctors_of_kenya/constants/constants.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: BackgroundPainter(),
            ),
            RegistrationBody(),
          ],
        ),
      ),
    );
  }
}

class RegistrationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: layoutPadding(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 100),
              const SizedBox(height: 16),
              Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 3,
                  child: StepperForm()),
              const SizedBox(height: 16),
              NavigationHelper(
                leading: "Already have an account?",
                action: "Login",
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepperForm extends StatefulWidget {
  @override
  _StepperFormState createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  int activeStep = 1; // Initial step set to 5.

  int upperBound = 3;
  bool maximum = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          NumberStepper(
            numbers: [
              1,
              2,
              3,
            ],

            // activeStep property set to activeStep variable defined above.
            activeStep: activeStep,

            // This ensures step-tapping updates the activeStep.
            onStepReached: (index) {
              setState(() {
                activeStep = index;
              });
            },
          ),
          Expanded(
            child: FittedBox(
              child: UserForm(
                activeStep: activeStep,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              previousButton(),
              nextButton(),
            ],
          ),
        ],
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: Colors.orange,
      padding: const EdgeInsets.all(12),
      onPressed: () {
        // Increment activeStep, when the next button is tapped.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
          if (activeStep == upperBound) {
            setState(() {
              maximum = true;
            });
            //register user with detailes
          }
        }
      },
      child: maximum
          ? Center(child: Text('Next'))
          : Center(child: Text('Complete')),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          'Prev',
          style: Theme.of(context).textTheme.button,
        ),
      ),
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
    );
  }
}

class UserForm extends StatefulWidget {
  final activeStep;
  const UserForm({Key key, this.activeStep}) : super(key: key);
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  //list of designations
  final List<String> designations = ['user', 'doctor'];
  //select sex
  final List<String> sexes = ['male', 'female'];
  //selected designation
  String _currentDesignation = 'user';
  String _selectedSex = 'male';
  //Controllers
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    switch (widget.activeStep) {
      case 1:
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 3),
              Text(
                'Create an Account',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(6),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(6),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.vpn_key),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(6),
                child: TextField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.vpn_key),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );

      case 2:
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'General Information',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(6),
                child: DropdownButtonFormField(
                  value: _currentDesignation ?? 'user',
                  decoration: InputDecoration(
                      labelText: 'Register',
                      prefixIcon: const Icon(Icons.person_outline)),
                  items: designations.map((designation) {
                    return DropdownMenuItem(
                      value: designation,
                      child: Text('$designation Account'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentDesignation = val),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: AnimatedSwitcher(
                  child: _currentDesignation == 'user'
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  prefixIcon: const Icon(Icons.person),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: DropdownButtonFormField(
                                value: _selectedSex ?? 'male',
                                decoration: InputDecoration(
                                    labelText: 'Sex',
                                    prefixIcon:
                                        const Icon(Icons.person_outline)),
                                items: sexes.map((sex) {
                                  return DropdownMenuItem(
                                    value: sex,
                                    child: Text('$sex'),
                                  );
                                }).toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedSex = val),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      prefixIcon: const Icon(Icons.email),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      prefixIcon: const Icon(Icons.email),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  prefixIcon: const Icon(Icons.person),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                               Container(
                              padding: const EdgeInsets.all(6),
                              child: DropdownButtonFormField(
                                value: _selectedSex ?? 'male',
                                decoration: InputDecoration(
                                    labelText: 'Sex',
                                    prefixIcon:
                                        const Icon(Icons.person_outline)),
                                items: sexes.map((sex) {
                                  return DropdownMenuItem(
                                    value: sex,
                                    child: Text('$sex'),
                                  );
                                }).toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedSex = val),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    prefixIcon: const Icon(Icons.email),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(6),
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    prefixIcon: const Icon(Icons.email),
                                  ),
                                ),
                              ),
                            ]),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Contacts',
                                  prefixIcon: const Icon(Icons.phone),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                  duration: Duration(seconds: 3),
                ),
              ),
            ],
          ),
        );

      case 3:
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 3),
              Text(
                'Private Information',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: AnimatedSwitcher(
                  child: _currentDesignation == 'user'
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Chronic Conditions',
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Medications',
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Primary Doctor',
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Other Doctors',
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'MPDB Number',
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'MPDB Date',
                                  prefixIcon: const Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Qualifications',
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                  duration: Duration(seconds: 3),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );

      default:
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 3),
              Text(
                'Create an Account',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(6),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email ID',
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(6),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.vpn_key),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(6),
                child: TextField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.vpn_key),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
    }
  }
}
