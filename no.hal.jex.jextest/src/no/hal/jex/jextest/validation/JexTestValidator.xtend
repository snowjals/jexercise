/*
 * generated by Xtext
 */
package no.hal.jex.jextest.validation

import org.eclipse.xtext.xbase.XExpression
import org.eclipse.xtext.validation.Check
import java.util.Collection
import no.hal.jex.jextest.jexTest.Parameter
import no.hal.jex.jextest.jexTest.StateFunction
import no.hal.jex.jextest.jexTest.JexTestPackage
import org.eclipse.emf.ecore.EStructuralFeature
import no.hal.jex.jextest.jexTest.Method

//import org.eclipse.xtext.validation.Check

/**
 * Custom validation rules. 
 *
 * see http://www.eclipse.org/Xtext/documentation.html#validation
 */
class JexTestValidator extends AbstractJexTestValidator {

//	override void mustBeJavaStatementExpression(XExpression expr) {
//	}

	// turn off warnings that expressions without side-effekts cannot be statements
	// since expressions are wrapped in the generated code, the warnings are not relevant
	override void checkInnerExpressions(XExpression expr) {
	}
	
	def checkVarargIsLast(Collection<Parameter> parameters, EStructuralFeature feature) {
		val iterator = parameters.iterator
		while (iterator.hasNext) {
			if (iterator.next.vararg && iterator.hasNext) {
				error('Only the last paramter can be a vararg', feature)
			}
		}
		true
	}
	
	@Check
	def checkVarargIsLast(StateFunction method) {
		checkVarargIsLast(method.parameters, JexTestPackage.Literals.STATE_FUNCTION__PARAMETERS)
	}
	
	@Check
	def checkVarargIsLast(Method method) {
		checkVarargIsLast(method.parameters, JexTestPackage.Literals.METHOD__PARAMETERS)
	}
}
